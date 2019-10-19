//
//  AuthAssemler.swift
//  Legio
//
//  Created by MIkkyMouse on 19/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthAssemblerProtocol {
    func assemble(with view: AuthView)
}

class AuthAssembler: AuthAssemblerProtocol {
    
    func assemble(with view: AuthView) {
        let router = AuthRouter(controller: view)
        let interactor = AuthInteractor()
        
        let presenter = AuthPresenter()
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
    }
    
}
