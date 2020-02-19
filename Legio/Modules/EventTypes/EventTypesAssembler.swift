//
//  EventTypesAssembler.swift
//  Legio
//
//  Created by Sergey Mikhailov on 30.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol EventTypesAssmblerProtocol {
    func assemble(with view: EventTypesView)
}

class EventTypesAssmbler: EventTypesAssmblerProtocol{
    func assemble(with view: EventTypesView) {
        let router = EventTypesRouter(controller: view)
        let interactor = EventTypesInteractor()
        
        let presenter = EventTypesPresenter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
    }
    
    
}
