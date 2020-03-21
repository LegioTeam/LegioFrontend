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
    
    func getEvents(dislikedEvents: [Int], completion: @escaping EventsResponse) {
        
        let target = MoyaProvider<EventsTarget>()
        target.request(.getEvents(dislikedEvents: dislikedEvents)) { result in
            
            switch result {
            case .success(let response):
                do {
                    let events = try response.map([Event].self)
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
