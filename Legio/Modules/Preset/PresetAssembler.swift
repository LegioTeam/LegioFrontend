//
//  PresetAssembler.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol PresetAssemblerProtocol {
    func assemble(with view: PresetView)
}

class PresetAssembler: PresetAssemblerProtocol {
    
    func assemble(with view: PresetView) {
        let router = PresetRouter(controller: view)
        let interactor = PresetInteractor()
        
        let presenter = PresetPresenter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
    }
    
}
