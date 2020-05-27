//
//  EventInteractor.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import CoreLocation

protocol EventInteractorProtocol {
    func getEvents(
        city: String?,
        location: CLLocation?,
        distance: Float?,
        metro: String?,
        completion: @escaping EventsService.EventsResult)
}

class EventInteractor: EventInteractorProtocol {
    
    var event: Event?
    private let eventsService: EventsService = EventsServiceImplementation()
    
    internal func getEvents(
        city: String? = nil,
        location: CLLocation? = nil,
        distance: Float? = nil,
        metro: String? = nil,
        completion: @escaping EventsService.EventsResult) {
        
        let locationString: String?
        if let location = location {
            locationString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        } else {
            locationString = nil
        }
        eventsService.getEvents(
            city: city,
            location: locationString,
            distance: distance,
            metro: metro,
            completion: completion)
    }
}

