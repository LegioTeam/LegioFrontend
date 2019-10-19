//
//  AuthPresenter.swift
//  Legio
//
//  Created by MIkkyMouse on 19/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthPresenterProtocol {
    func authTapped(email: String?, password: String?)
}

class AuthPresenter {
    
    var router: AuthRouterProtocol!
    var interactor: AuthInteractorProtocol!
    var chekLoginAndPassword = EnableButton()
   
}

extension AuthPresenter: AuthPresenterProtocol {
    
    func authTapped(email: String?, password: String?) {
        guard let email = chekLoginAndPassword.validate(email: email),
        let password = chekLoginAndPassword.validate(password: password) else {
           return
        }
        auth(email: email, password: password)
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
}
