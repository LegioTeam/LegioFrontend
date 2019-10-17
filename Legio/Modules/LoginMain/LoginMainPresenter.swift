//
//  LoginMainPresenter.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol LoginMainPresenterProtocol: class {
	func registerTapped()
	func facebookTapped()
	func vkTapped()
	func authTapped()
    
}

class LoginMainPresenter {
	weak var view: LoginMainViewProtocol?
	var interactor: LoginMainInteractorProtocol!
	var router: LoginMainRouterProtocol!
	
	private let notReadyError = "This feature is not available yet"
}

extension LoginMainPresenter: LoginMainPresenterProtocol {
	
	func registerTapped() {
		router.showRegister()
	}
	
	func facebookTapped() {
		view?.show(error: notReadyError)
	}
	
	func vkTapped() {
		view?.show(error: notReadyError)
	}
	
	func authTapped() {
		router.showAuth()
	}
	
   

}


