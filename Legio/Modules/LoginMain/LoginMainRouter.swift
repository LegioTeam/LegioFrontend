//
//  LoginMainRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol LoginMainRouterProtocol: class {
	func showAuth()
	func showVkontakte()
	func showFacebook()
	func showRegister()
}

class LoginMainRouter: BaseRouter {
	
}

extension LoginMainRouter: LoginMainRouterProtocol {
	
	func showRegister() {
		guard let controller = UIStoryboard(name: "Register", bundle: nil)
			.instantiateViewController(withIdentifier:  RegisterView.storyboardIdentifier) as? RegisterView else {
				return
		}
		let assembler: RegisterAssemblerProtocol = RegisterAssembler()
		assembler.assemble(with: controller)
		self.show(controller)
	}
	
	func showVkontakte() {
		print("nil")
	}
	
	func showFacebook() {
		print("nil")
	}
	
	func showAuth() {
		guard let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(withIdentifier: AuthView.storyboardIdentifier) as? AuthView else { return }
        let assemler: AuthAssemblerProtocol = AuthAssembler()
        assemler.assemble(with: controller)
		self.show(controller)
	}
	
}
