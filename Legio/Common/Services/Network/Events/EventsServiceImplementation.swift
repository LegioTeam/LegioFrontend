//
//  EventsServiceImplementation.swift
//  Legio
//
//  Created by Mac on 08.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Moya
import Alamofire

class EventsServiceImplementation: EventsService {
    
    private let authPlugin = AccessTokenPlugin { _ in
        NetworkSettings.shared.token
    }
    
    func getEvents(
        city: String?,
        location: String?,
        distance: Float?,
        metro: String?,
        completion: @escaping EventsResult) {
        
        let target = MoyaProvider<EventsTarget>(
        plugins: [authPlugin])
        target.request(.getEvents(
            city: city,
            location: location,
            distance: distance,
            metro: metro)) { result in
                
                switch result {
                case .success(let response):

                    #if DEBUG
                     let responseString = String(decoding: response.data, as: UTF8.self)
                     print(responseString)
                    #endif
                    
                    do {
                        let events = try response.map(EventsResponse.self)
                        completion(.success(events))
                        
                    } catch {
                        completion(.failure(NetworkError.decodable))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
        }
    }
}
