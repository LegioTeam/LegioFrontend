//
//  AuthServiceImplementation.swift
//  Legio
//
//  Created by Mac on 29.02.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Moya
import Alamofire

class AuthServiceImplementation: AuthService {
    
    func signIn(identity: String, password: String, completion: @escaping AuthResponse) {
        
        let target = MoyaProvider<AuthTarget>()
        target.request(.signIn(
            identity: identity,
            password: password)) { result in
                
                switch result {
                case .success(let response):
                    do {
                        let singInResponse = try response.map(UserProfile.self)
                        completion(.success(singInResponse))
                        
                    } catch {
                        completion(.failure(NetworkError.decodable))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
        }
    }
    
    func register(identity: String, password: String, completion: @escaping AuthResponse) {
        
        let target = MoyaProvider<AuthTarget>()
        target.request(.register(
            identity: identity,
            password: password)) { result in
                
                switch result {
                case .success(let response):
                    do {
                        let registerResponse = try response.map(UserProfile.self)
                        completion(.success(registerResponse))
                    } catch {
                        completion(.failure(NetworkError.decodable))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
        }
    }
}
