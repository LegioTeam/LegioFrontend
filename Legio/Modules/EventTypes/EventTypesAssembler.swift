//
//  EventTypesAssembler.swift
//  Legio
//
//  Created by Mac on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesAssemblerProtocol {
    func assemble(with view: EventTypesView)
}

class EventTypesAssembler: EventTypesAssemblerProtocol {
    
    func assemble(with view: EventTypesView) {
        let router = EventTypesRouter(controller: view)
        let interactor = EventTypesInteractor()
        
        let presenter = EventTypesPresenter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        presenter.locationService = LocationManager.sharedManager
        
        view.presenter = presenter
    }

}
