//
//  Event.swift
//  Legio
//
//  Created by Mac on 08.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

enum ModerationStatus: String, Codable {
    case shown = "shown"
}

class Event: Codable {
    
    let id: String
    let name: String
    let startsAt: String
    let description: String
    
    let location: Location
    
    let url: String?
    let posterImage: PosterImage?
    
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case startsAt = "startsAt"
        case name = "name"
        case description = "description"
        case url = "url"
        case posterImage = "poster"
        case location = "location"
        case categories = "categories"
    }
    
}
