//
//  NetworkError.swift
//  Legio
//
//  Created by Mac on 01.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodable
    case emptyData
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .decodable:
            return NSLocalizedString("Некорректный ответ от сервера", comment: "Incorrect network response")
            
        case .emptyData:
            return NSLocalizedString("Отсутствуют данные", comment: "Empty data")
        }
    }
}
