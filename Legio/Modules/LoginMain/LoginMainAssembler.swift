//
//  LoginMainAssembler.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol LoginMainAssemblerProtocol: class {
	func assemble(with view: LoginMainView)
}

class LoginMainAssembler: LoginMainAssemblerProtocol {
	
	func assemble(with view: LoginMainView) {
		let router = LoginMainRouter(controller: view)
		let interactor = LoginMainInteractor()
		
		let presenter = LoginMainPresenter()
		presenter.router = router
		presenter.interactor = interactor
        presenter.view = view
		
		view.presenter = presenter
	}
}
