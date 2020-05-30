//
//  RootInteractor.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

/// Протокол для Root Interactor
protocol RootInteractorProtocol {
    
    /// Является ли пользователь авторизованным
    func isAuthorized() -> Bool
    
    /// Авторизация пользователя и получение токена
    func signIn(completion: @escaping (Error?) -> Void)
    
    /// Проверка наличия интересов
    func haveInterests(completion: @escaping (Bool) -> Void)
}

final class RootInteractor: RootInteractorProtocol {
    
    private let authService: AuthService
    private let databaseService: DatabaseService
    private let interestsService: InterestsService
    
    private let networkSettings = NetworkSettings.shared
    
    init(
        with authService: AuthService,
        databaseService: DatabaseService,
        interestsService: InterestsService) {
        self.authService = authService
        self.databaseService = databaseService
        self.interestsService = interestsService
    }
    
    func isAuthorized() -> Bool {
        guard let token = databaseService.getToken() else {
            return false
        }
        
        networkSettings.token = token
        return true
    }
    
    func signIn(completion: @escaping (Error?) -> Void) {
        
        authService.getToken { [weak self] result in
            switch result {
            case .success(let token):
                self?.networkSettings.token = token
                completion(nil)
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func haveInterests(completion: @escaping (Bool) -> Void) {
        
        interestsService.myInterests { result in
            switch result {
            case .success(let interests):
                completion(interests.count > 0)
                
            case .failure:
                completion(false)
            }
        }
    }
}
