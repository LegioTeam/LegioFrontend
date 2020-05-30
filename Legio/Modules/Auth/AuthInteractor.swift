//
//  AuthInteractor.swift
//  Legio
//
//  Created by MIkkyMouse on 19/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthInteractorProtocol {
    func checkValid(login: String?) -> String?
    func checkValid(password: String?) -> String?
    func auth(email: String, password: String, completion: @escaping AuthService.AuthResponse)
    func save(token: String)
}

class AuthInteractor: AuthInteractorProtocol {
    
    private let networkService = NetworkSettings.shared
    private let validateManager: ValidateManager = ValidateManager()
    private let authService: AuthService = AuthServiceImplementation(
    with: KeychainDatabaseServiceImplementation.instance)
    
    func auth(email: String, password: String, completion: @escaping AuthService.AuthResponse) {
        authService.signIn(identity: email, password: password, completion: completion)
    }
    
    internal func checkValid(login: String?) -> String? {
        return validateManager.validate(email: login)
    }
    
    internal func checkValid(password: String?) -> String? {
        return validateManager.validate(password: password)
    }
    
    internal func save(token: String) {
        networkService.token = token
    }
    
}
