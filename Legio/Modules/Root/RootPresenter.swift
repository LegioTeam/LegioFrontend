//
//  RootPresenter.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RootPresenterProtocol: class {
	func viewDidLoad()
}

class RootPresenter {
	weak var view: RootViewProtocol?
	var interactor: RootInteractorProtocol!
	var router: RootRouterProtocol!
	
}

extension RootPresenter: RootPresenterProtocol {
	
	func viewDidLoad() {
//		router.showLoginMain()
        router.showEventTypes()
	}
	
}
