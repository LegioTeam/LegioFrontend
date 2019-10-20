//
//  RegisterAssembler.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RegisterAssemblerProtocol: class {
	func assemble(with view: RegisterView)
}

class RegisterAssembler: RegisterAssemblerProtocol {
	
	func assemble(with view: RegisterView) {
		let router = RegisterRouter(controller: view)
		let interactor = RegisterInteractor()
		
		let presenter = RegisterPresenter()
		presenter.router = router
		presenter.interactor = interactor
        presenter.view = view
		
		view.presenter = presenter
	}
}

