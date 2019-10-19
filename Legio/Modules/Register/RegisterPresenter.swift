//
//  RegisterPresenter.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol RegisterPresenterProtocol: class {
    func registrateTapped(email: String?, password: String?)
}

class RegisterPresenter {
    
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol!
    var router: RegisterRouterProtocol!
    let chekLoginPasswprd = EnableButton()

    
    private let incorrectDataError = "You set incorrect data"
    
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func registrateTapped(email: String?, password: String?) {
        guard let email = chekLoginPasswprd.validate(email: email),
            let password = chekLoginPasswprd.validate(password: password) else {
                self.view?.show(error: incorrectDataError)
                return
        }
        registrate(email: email, password: password)
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
    
}



