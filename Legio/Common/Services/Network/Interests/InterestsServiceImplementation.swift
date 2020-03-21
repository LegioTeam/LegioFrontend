//
//  InterestsServiceImplementation.swift
//  Legio
//
//  Created by Mac on 17.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Moya
import Alamofire

class InterestsServiceImplementation: InterestsService {
    
    private let authPlugin = AccessTokenPlugin { _ in
        NetworkSettings.shared.token
    }
    
    func interestsList(completion: @escaping AllInterestsResponse) {
        let target = MoyaProvider<InterestsTarget>()
        target.request(.interestsList) { result in
            
            switch result {
            case .success(let response):
                do {
                    let interestsList = try response.map(InterestsList.self)
                    completion(.success(interestsList))
                } catch {
                    completion(
                    .failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func myInterests(completion: @escaping MyInterestsResponse) {
        
        let target = MoyaProvider<InterestsTarget>(
        plugins: [authPlugin])
        target.request(.myInterests) { result in
            
            switch result {
            case .success(let response):
                
                #if DEBUG
                 let responseString = String(decoding: response.data, as: UTF8.self)
                 print(responseString)
                #endif
                
                do {
                    let interestsList = try response.map([Int].self)
                    completion(.success(interestsList))
                } catch {
                    completion(
                    .failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(idMyInterests: [Int], completion: @escaping MyInterestsResponse) {
    
        let target = MoyaProvider<InterestsTarget>(
            plugins: [authPlugin])
        target.request(.update(idMyInterests: idMyInterests)) { result in
            
            switch result {
            case .success(let response):
                
                #if DEBUG
                 let responseString = String(decoding: response.data, as: UTF8.self)
                 print(responseString)
                #endif
                
                do {
                    let userIntererests = try response.map([Int].self)
                    completion(.success(userIntererests))
                } catch {
                    completion(
                    .failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(idMyInterests: [Int], completion: @escaping MyInterestsResponse) {
    
        let target = MoyaProvider<InterestsTarget>(
            plugins: [authPlugin])
        target.request(.add(idMyInterests: idMyInterests)) { result in
            
            switch result {
            case .success(let response):
                
                #if DEBUG
                 let responseString = String(decoding: response.data, as: UTF8.self)
                 print(responseString)
                #endif
                
                do {
                    let userIntererests = try response.map([Int].self)
                    completion(.success(userIntererests))
                } catch {
                   completion(
                    .failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
