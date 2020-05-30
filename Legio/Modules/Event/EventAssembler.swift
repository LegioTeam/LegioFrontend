//
//  EventAssembler.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol EventAssemblerProtocol: class {
    func assemble(with view: EventView)
    func assembleFromButton(with view: EventView)
}

final class EventAssembler: EventAssemblerProtocol {
    
    func assemble(with view: EventView) {
        
        let router = EventRouter(controller: view)
        
        let eventsService = EventsServiceImplementation()
        let notificationService = NotificationServiceImplementation()
        let interactor = EventInteractor(
            eventsService: eventsService,
            notificationService: notificationService)
        
        let presenter = EventPresenter()
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        presenter.locationService = LocationManager.sharedManager
        
        view.presenter = presenter
        view.mainEvent = true
    }
    
    func assembleFromButton(with view: EventView) {
        
        let router = EventRouter(controller: view)
        
        let eventsService = EventsServiceImplementation()
        let notificationService = NotificationServiceImplementation()
        let interactor = EventInteractor(
            eventsService: eventsService,
            notificationService: notificationService)
       
        let presenter = EventPresenter()
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        view.mainEvent = false
    }
}

