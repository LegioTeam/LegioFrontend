//
//  InterestsTarget.swift
//  Legio
//
//  Created by Mac on 17.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation
import Moya

enum InterestsTarget {
    case interestsList
    case update(idMyInterests: [Int])
    case add(idMyInterests: [Int])
    case myInterests
}

extension InterestsTarget: TargetType, AccessTokenAuthorizable {
    
    private enum Keys {
        static let contentType = "Content-Type"
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
        case .interestsList: return "/interests"
            
        case .add, .update, .myInterests:
            return "/profile/interests"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .interestsList: return .get
            
        case .myInterests: return .get
            
        case .add: return .post
            
        case .update: return .put
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
        case .interestsList, .myInterests:
            return .requestPlain
        
        case .add(let idMyInterests):
            guard let data = convertToData(array: idMyInterests) else {
                fatalError("Cannot convert array to data")
            }
            return .requestData(data)
        
        case .update(let idMyInterests):
            guard let data = convertToData(array: idMyInterests) else {
                fatalError("Cannot convert array to data")
            }
            return .requestData(data)
        }
    }
    
    public var headers: [String: String]? {
        return [Keys.contentType: Constants.contentTypeValue]
    }
    
    private func convertToData(array: [Int]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: array, options: [])
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .add, .myInterests, .update:
            return .bearer
            
        case .interestsList:
            return nil
        }
    }
    
    
}
