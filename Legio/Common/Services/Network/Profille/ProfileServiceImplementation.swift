//
//  ProfileServiceImplementation.swift
//  Legio
//
//  Created by Mac on 07.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Moya
import Alamofire

class ProfileServiceImplementation: ProfileService {
    
    func getProfile(completion: @escaping GetProfileResponse) {
        
        let target = MoyaProvider<ProfileTarget>()
        target.request(.getProfile) { result in
            
            switch result {
            case .success(let response):
                do {
                    let profileResponse = try response.map(Profile.self)
                    completion(.success(profileResponse))
                    
                } catch {
                    completion(.failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func add(interests: [String], completion: @escaping InterestsResponse) {
        
        let target = MoyaProvider<ProfileTarget>()
        target.request(.add(interests: interests)) { result in
            
            switch result {
            case .success(let response):
                do {
                    let interests = try response.map([String].self)
                    completion(.success(interests))
                    
                } catch {
                    completion(.failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func change(interests: [String], completion: @escaping InterestsResponse) {
        
        let target = MoyaProvider<ProfileTarget>()
        target.request(.add(interests: interests)) { result in
            
            switch result {
            case .success(let response):
                do {
                    let interests = try response.map([String].self)
                    completion(.success(interests))
                    
                } catch {
                    completion(.failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    
}
