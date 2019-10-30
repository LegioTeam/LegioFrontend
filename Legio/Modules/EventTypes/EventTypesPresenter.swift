//
//  EventTypesPresenter.swift
//  Legio
//
//  Created by Sergey Mikhailov on 30.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol EventTypesPresenterProtocol {
    func showEventTypped()
}

class EventTypesPresenter : EventTypesPresenterProtocol{
    
    weak var view: EventTypesView?
    var interactor: EventTypesInteractor!
    var router: EventTypesRouter!
    
    func showEventTypped() {
        router.showEvent()
    }
    
    func getEventTypes() ->[EventTypesEntity<String>]{
        return interactor.getData()
    }
    
    func getEventTypeByIndex(index: IndexPath) ->EventTypesEntity<String>{
        return interactor.getData()[index.row]
    }
}
