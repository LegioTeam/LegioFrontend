//
//  EventsResponse.swift
//  Legio
//
//  Created by Mac on 26.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

final class EventsResponse: Codable {
    
    let events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case events = "events"
    }
}
