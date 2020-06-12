//
//  EventInteractor.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import CoreLocation

protocol EventInteractorProtocol {
    
    /// Метод получения списка событий
    func getEvents(
        city: String?,
        location: CLLocation?,
        distance: Float?,
        metro: String?,
        completion: @escaping EventsService.EventsResult)
    
    /// Лайкнуть событие
    func like(event: Event, completion: @escaping EventsService.ReactionResult)
    
    /// Дислайкнуть событие
    func dislike(event: Event, completion: @escaping EventsService.ReactionResult)
    
}

final class EventInteractor: EventInteractorProtocol {
    
    private let eventsService: EventsService
    private let notificationService: NotificationService
    
    init(eventsService: EventsService,
         notificationService: NotificationService) {
        self.eventsService = eventsService
        self.notificationService = notificationService
    }
    
    func getEvents(
        city: String? = nil,
        location: CLLocation? = nil,
        distance: Float? = nil,
        metro: String? = nil,
        completion: @escaping EventsService.EventsResult) {
        
        let locationString = makeString(from: location)
        eventsService.getEvents(
            city: city,
            location: locationString,
            distance: distance,
            metro: metro,
            completion: completion)
    }
    
    func like(event: Event, completion: @escaping EventsService.ReactionResult) {
        
        eventsService.like(eventId: event.id, completion: { [weak self] result in
            switch result {
            case .success:
                self?.notificationService.addNotification(for: event)
            
            case.failure:
                break
                
            }
            completion(result)
        })
    }
    
    func dislike(event: Event, completion: @escaping EventsService.ReactionResult) {
        
        eventsService.dislike(eventId: event.id, completion: completion)
    }
    
    private func makeString(from location: CLLocation?) -> String? {
        
        let locationString: String?
        if let location = location {
            locationString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        } else {
            locationString = nil
        }
       
        return locationString
    }
}
