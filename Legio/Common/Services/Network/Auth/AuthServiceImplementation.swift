//
//  AuthServiceImplementation.swift
//  Legio
//
//  Created by Mac on 29.02.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Moya
import Alamofire

final class AuthServiceImplementation: AuthService {
    
    private let databaseService: DatabaseService
    required init(with databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func getToken(completion: @escaping TokenResponse) {
        let target = MoyaProvider<AuthTarget>()
        target.request(.token) { [weak self] result in
            
            switch result {
            case .success(let response):
                
                do {
                    let unsafeToken = try response.map(UnsafeToken.self)
                    self?.databaseService.save(token: unsafeToken.token)
                    completion(.success(unsafeToken.token))
                    
                } catch {
                    completion(.failure(NetworkError.decodable))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signIn(identity: String, password: String, completion: @escaping AuthResponse) {
        
        let target = MoyaProvider<AuthTarget>()
        target.request(.signIn(
            identity: identity,
            password: password)) { [weak self] result in
                
                switch result {
                case .success(let response):
                    do {
                        if 200 ... 299 ~= response.statusCode {
                            let singInResponse = try response.map(UserProfile.self)
                            self?.databaseService.save(login: identity, password: password)
                            completion(.success(singInResponse))
                            
                        } else {
                            completion(.failure(NetworkError.decodable))
                        }
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
                        if 200 ... 299 ~= response.statusCode {
                            let registerResponse = try response.map(UserProfile.self)
                            completion(.success(registerResponse))
                            
                        } else {
                            completion(.failure(NetworkError.decodable))
                        }
                    } catch {
                        completion(.failure(NetworkError.decodable))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
