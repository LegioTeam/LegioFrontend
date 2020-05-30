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

final class Interest: Codable {

    let id: Int
    let name: String
    let type: InterestType.RawValue
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case tags = "tags"
    }
}

