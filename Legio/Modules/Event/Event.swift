//
//  Event.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import CoreLocation

struct Event: Codable {
    var id: Int
    var created: String
    var updated: String
    var name: String
    var category: Int
    var createdAt: String
    var starts: String
    var ends: String
    var image: String
    var url: String
    var location: String
    var organization: String
    var tagName: String
    var categoryName: String
    var coordinates: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case updated = "updated_at"
        case name
        case category
        case createdAt = "created_at_"
        case starts = "starts_at"
        case ends = "ends_at"
        case image = "poster_image"
        case url
        case location
        case organization
        case tagName = "tag_name"
        case categoryName = "category_name"
        case coordinates
    }
    
}

