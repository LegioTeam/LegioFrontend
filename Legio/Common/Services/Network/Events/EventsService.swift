//
//  EventsService.swift
//  Legio
//
//  Created by Mac on 08.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import CoreLocation

protocol EventsService {
    
    func getEvents(
        city: String?,
        location: String?,
        distance: Float?,
        metro: String?,
        completion: @escaping EventsResult)
}

extension EventsService {
    
    public typealias EventsResult = (Result<EventsResponse, Error>) -> Void
}
