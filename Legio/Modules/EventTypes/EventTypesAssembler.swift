//
//  EventTypesAssembler.swift
//  Legio
//
//  Created by Mac on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesAssemblerProtocol {
    func assemble(with view: EventTypesView, needReturn: Bool)
}

extension EventTypesAssemblerProtocol {
    func assemble(with view: EventTypesView, needReturn: Bool = false) {
        assemble(with: view, needReturn: needReturn)
    }
}

class EventTypesAssembler: EventTypesAssemblerProtocol {
    
    func assemble(with view: EventTypesView, needReturn: Bool) {
        let router = EventTypesRouter(controller: view)
        let interactor = EventTypesInteractor()
        
        let presenter = EventTypesPresenter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        presenter.needReturn = needReturn
        presenter.locationService = LocationManager.sharedManager
        
        view.presenter = presenter
    }

}
