//
//  RootAssembler.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RootAssemblerProtocol: class {
	func assemble(with view: RootView)
}

class RootAssembler: RootAssemblerProtocol {
	
	func assemble(with view: RootView) {
		let router = RootRouter(controller: view)
		let interactor = RootInteractor()
		
		let presenter = RootPresenter()
		presenter.router = router
		presenter.interactor = interactor
        presenter.view = view
		
		view.presenter = presenter
	}
}
