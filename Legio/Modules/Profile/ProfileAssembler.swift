//
//  ProfileAssembler.swift
//  Legio
//
//  Created by MIkkyMouse on 31/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProfileAssemblerProtocol: class {
    func assemble(with view: ProfileView)
}

class ProfileAssembler: ProfileAssemblerProtocol {
    
    func assemble(with view: ProfileView) {
        let router = ProfileRouter(controller: view)
        let interactor = ProfileInteractor()
        
        let presenter = ProfilePresenter()
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
    }
}
