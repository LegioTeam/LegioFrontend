//
//  Interest.swift
//  Legio
//
//  Created by Mac on 19.12.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

enum InterestType: String {
    case party
    case nerby
}

class Interest: Codable {

    var id: Int
    var name: String
    var type: InterestType.RawValue
    var tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case tags = "tags"
    }
}

