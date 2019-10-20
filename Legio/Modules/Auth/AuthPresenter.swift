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
        updateButtonLogin()
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
        updateButtonLogin()
    }
}

extension AuthPresenter {
    
    private func auth(email: String, password: String) {
        // progress hud load
        interactor.auth(email: email, password: password) { (userData, error) in
            // self?. progress hud finish load
            if let userData = userData {
                //do something with data
                self.router.showSingIn()
            } else {
                let errorText = error?.localizedDescription ?? "some network error"
            }
        }
    }
    
    private func updateLoginViews(isValidated: Bool) {
        view?.updateLoginAlert(isHidden: isValidated)
        
        let validateProgress = getProgress(isValidated: isValidated)
        view?.updateLoginProgressBar(progress: validateProgress)
        
        let shownImage = getValidImage(isValidated: isValidated)
        view?.updateLoginSuccess(image: shownImage)
    }
    
    private func updatePasswordViews(isValidated: Bool) {
        view?.updatePasswordAlert(isHidden: isValidated)
        
        let validateProgress = getProgress(isValidated: isValidated)
        view?.updatePasswordProgressBar(progress: validateProgress)
        
        let shownImage = getValidImage(isValidated: isValidated)
        view?.updatePasswordSuccess(image: shownImage)
    }
    
    private func updateButtonLogin() {
           let buttonRegisterIsEnabled = isCorrectData()
        view?.updateButtonLogin(isEnabled: buttonRegisterIsEnabled)
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
