//
//  InterestsResponse.swift
//  Legio
//
//  Created by Mac on 17.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

class InterestsList: Codable {
    
    var interests: [Interest]
    
    enum CodingKeys: String, CodingKey {
        case interests = "interests"
    }
}
