//
//  User.swift
//  Legio
//
//  Created by Mac on 01.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

final class UserProfile: Codable {
    
    let token: String?
    let name: String?
    let identity: String?
    let interests: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "friendlyName"
        case identity = "identity"
        case token = "token"
        case interests = "interests"
    }
}
