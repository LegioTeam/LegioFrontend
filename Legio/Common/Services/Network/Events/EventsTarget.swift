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
    
    case getEvents(
        city: String?,
        location: String?,
        distance: Float?,
        metro: String?)
    
    case like(eventId: String)
    
    case dislike(eventId: String)
}

extension EventsTarget: TargetType, AccessTokenAuthorizable {
    
    private enum Keys {
        static let contentType = "Content-Type"
        static let header = "X-Auth-Token"
        static let dislikedEvents = "dislikes"
        
        static let city = "city"
        static let location = "location"
        static let distance = "distance"
        static let metro = "metro"
        
        static let eventId = "eventId"
        static let type = "type"
    }
    
    private enum Constants {
        static let contentTypeValue = "application/json"
        static let like = "like"
        static let dislike = "dislike"
    }
    
    var baseURL: URL {
        guard let url = URL(string: NetworkSettings.shared.baseUrlString) else {
            fatalError("base Url cannot be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getEvents:
            return "/events"
            
        case .like, .dislike:
            return "/profile/reactions"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getEvents:
            return .get
            
        case .like, .dislike:
            return .post
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
        case .getEvents(
            let city,
            let location,
            let distance,
            let metro):
            
            var parameters: [String: Any] = [:]
            if let city = city {
                parameters[Keys.city] = city
            }
            if let location = location {
                parameters[Keys.location] = location
            }
            if let distance = distance {
                parameters[Keys.distance] = distance
            }
            if let metro = metro {
                parameters[Keys.metro] = metro
            }
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default)
            
        case .like(let eventId):
            var parameters: [String: Any] = [:]
            parameters[Keys.type] = Constants.like
            parameters[Keys.eventId] = eventId
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.httpBody)
            
        case .dislike(let eventId):
            var parameters: [String: Any] = [:]
            parameters[Keys.type] = Constants.dislike
            parameters[Keys.eventId] = eventId
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.httpBody)
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .getEvents:
            return [Keys.contentType: Constants.contentTypeValue]
            
        default:
            return nil
        }
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
}



