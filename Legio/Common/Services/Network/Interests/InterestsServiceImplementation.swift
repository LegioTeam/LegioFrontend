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
    
    func interestsList(completion: @escaping InterestsResponse) {
        let target = MoyaProvider<InterestsTarget>()
        target.request(.interestsList) { result in
            
            switch result {
            case .success(let response):
                do {
                    let interestsList = try response.map(InterestsList.self)
                    completion(.success(interestsList))
                    
                } catch {
                    completion(.failure(NetworkError.decodableError))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func myInterests(completion: @escaping InterestsResponse) {
        let target = MoyaProvider<InterestsTarget>()
        target.request(.myInterests) { result in
            
            switch result {
            case .success(let response):
                do {
                    let interestsList = try response.map(InterestsList.self)
                    completion(.success(interestsList))
                    
                } catch {
                    completion(.failure(NetworkError.decodableError))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func update(idMyInterests: [Int]) {
        let target = MoyaProvider<InterestsTarget>()
        target.request(.update(idMyInterests: idMyInterests)) { result in
            
            switch result {
            case .success(let response):
                
                print(response.description)
               
                let responseString = String(decoding: response.data, as: UTF8.self)
                print(responseString)
                do {
                    let interestsList = try response.map(InterestsList.self)
                    
                    
                } catch {
                   
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
