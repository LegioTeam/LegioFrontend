//
//  RegisterPresenter.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol RegisterPresenterProtocol: class {
    func registrateTapped()
    func changed(login: String?)
    func changed(password: String?)
}

class RegisterPresenter {
    
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol!
    var router: RegisterRouterProtocol!
    
    private var login: String?
    private var password: String?

    private let validImage = UIImage(named: "checkMarkTF")
    private let incorrectDataError = "You set incorrect data"
    
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func registrateTapped() {
        guard let email = login,
            let password = password else {
                self.view?.show(error: incorrectDataError)
                return
        }
        registrate(email: email, password: password)
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
        updateButtonRegister()
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
        updateButtonRegister()
    }
}

extension RegisterPresenter {
    
    private func registrate(email: String, password: String) {
        // progress hud load
        interactor.registrate(email: email, password: password) { [weak self] (userData, error) in
            // self?. progress hud finish load
            if let userData = userData {
                //do something with data
                self?.router.showSingIn()
            } else {
                let errorText = error?.localizedDescription ?? "some network error"
                self?.view?.show(error: errorText)
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
    
    private func updateButtonRegister() {
           let buttonRegisterIsEnabled = isCorrectData()
        view?.updateButtonRegister(isEnabled: buttonRegisterIsEnabled)
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



