//
//  EventsTarget.swift
//  Legio
//
//  Created by Mac on 08.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation
import Moya

enum EventsTarget {
    case getEvents(dislikedEvents: [Int])
}

extension EventsTarget: TargetType {
    
    private enum Keys {
        static let contentType = "Content-Type"
        static let header = "X-Auth-Token"
        static let dislikedEvents = "dislikes"
    }
    
    private enum Constants {
        static let contentTypeValue = "application/json"
    }
    
    var baseURL: URL {
        guard let url = URL(string: NetworkSettings.shared.baseUrlString) else {
            fatalError("base Url cannot be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getEvents(let dislikedEvents):
            if dislikedEvents.count > 0 {
                let dislikedString = dislikedEvents.map({"\($0)"}).joined(separator: ",")
                return "/events?\(Keys.dislikedEvents)={\(dislikedString)}"
                
            } else {
                return "/events"
            }
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getEvents: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var task: Task {
        switch self {
        case .getEvents:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        
        var headers: [String: String] = [Keys.contentType: Constants.contentTypeValue]
        
//        if let token = NetworkSettings.shared.token {
//            headers[Keys.header] = token
//        }
        return headers
    }
    
    
}



