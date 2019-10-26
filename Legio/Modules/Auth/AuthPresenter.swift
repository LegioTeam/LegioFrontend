//
//  AuthPresenter.swift
//  Legio
//
//  Created by MIkkyMouse on 19/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthPresenterProtocol {
    func authTapped()
    func changed(login: String?)
    func changed(password: String?)
}

class AuthPresenter {
    
    weak var view: AuthViewProtocol?
    var router: AuthRouterProtocol!
    var interactor: AuthInteractorProtocol!

    private var login: String?
    private var password: String?

    private let validImage = UIImage(named: "checkMarkTF")
   
}

extension AuthPresenter: AuthPresenterProtocol {
    
    func authTapped() {
        guard let email = self.login,
        let password = self.password else {
            if self.login == nil {
                showLoginError(isCorrect: false)
            }
            if self.password == nil {
                showPasswordError(isCorrect: false)
            }
           return
        }
        auth(email: email, password: password)
    }
    
    func changed(login: String?) {
        var isValidated = false
        if let validateLogin = interactor.checkValid(login: login) {
            self.login = validateLogin
            isValidated = true
        } else {
            self.login = nil
        }
        updateLoginViews(isValidated: isValidated)
        showLoginError(isCorrect: true)
        showPasswordError(isCorrect: true)
    }
    
    func changed(password: String?) {
        var isValidated = false
        if let validatePassword = interactor.checkValid(password: password) {
            self.password = validatePassword
            isValidated = true
        } else {
            self.password = nil
        }
        updatePasswordViews(isValidated: isValidated)
        showLoginError(isCorrect: true)
        showPasswordError(isCorrect: true)
    }
    
}

extension AuthPresenter {
    
    private func auth(email: String, password: String) {
        // progress hud load
        interactor.auth(email: email, password: password) { [weak self] (userData, error) in
            // self?. progress hud finish load
            /*
            if let userData = userData {
                //do something with data
                self.router.showSingIn()
            } else {
                let errorText = error?.localizedDescription ?? "some network error"
            }
            */
            self?.router.showSingIn()
        }
    }
    
    private func updateLoginViews(isValidated: Bool) {
        let shownImage = getValidImage(isValidated: isValidated)
        view?.updateLoginSuccess(image: shownImage)
    }
    
    private func showLoginError(isCorrect: Bool) {
        view?.updateLoginAlert(isHidden: isCorrect)
        
        let validateProgress = getProgress(isValidated: isCorrect)
        view?.updateLoginProgressBar(progress: validateProgress)
    }
    
    private func updatePasswordViews(isValidated: Bool) {
        let shownImage = getValidImage(isValidated: isValidated)
        view?.updatePasswordSuccess(image: shownImage)
    }
    
    private func showPasswordError(isCorrect: Bool) {
        view?.updatePasswordAlert(isHidden: isCorrect)
        
        let validateProgress = getProgress(isValidated: isCorrect)
        view?.updatePasswordProgressBar(progress: validateProgress)
    }
    
    private func getProgress(isValidated: Bool) -> Float {
        return isValidated
            ? 0.0
            : 1.0
    }
    
    private func getValidImage(isValidated: Bool) -> UIImage? {
        return isValidated
            ? validImage
            : nil
    }
    
    private func isCorrectData() -> Bool {
        guard self.login != nil ,
            self.password != nil else {
                return false
        }
        return true
    }
}
