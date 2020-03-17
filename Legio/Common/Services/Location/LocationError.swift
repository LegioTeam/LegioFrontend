//
//  LocationError.swift
//  Legio
//
//  Created by Sergey Mikhailov on 17.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

enum LocationError: Error {
    case fetchFailed(String)
    case reverseGeocodeFailed(String)
    case unauthorized(String)
}

extension LocationError {
    
    var message: String {
        switch self {
        case .fetchFailed(let message),
             .reverseGeocodeFailed(let message),
             .unauthorized(let message):
            return message
        }
    }
}
