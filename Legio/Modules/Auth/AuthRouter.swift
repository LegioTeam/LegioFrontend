//
//  AuthRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthRouterProtocol: class {
	func showSingIn()
	func showForgot()
	func showRegister()
}

class AuthRouter: BaseRouter {
	
}

extension AuthRouter: AuthRouterProtocol {
	
	func showSingIn() {
		guard let controller = UIStoryboard(name: "Preset", bundle: nil)
            .instantiateViewController(withIdentifier: PresetView.storyboardIdentifier) as? PresetView else { return }
        let assembler: PresetAssemblerProtocol = PresetAssembler()
        assembler.assemble(with: controller)
        self.show(controller)
	}
	
	func showForgot() {
		let controller = UIStoryboard(name: "Forgot", bundle: nil)
			.instantiateViewController(withIdentifier: ForgotView.storyboardIdentifier)
		self.show(controller)
	}
	
	func showRegister() {
		let controller = UIStoryboard(name: "Register", bundle: nil)
			.instantiateViewController(withIdentifier: RegisterView.storyboardIdentifier)
		self.show(controller)
	}
	
//	func showAuth() {

//	}
}

