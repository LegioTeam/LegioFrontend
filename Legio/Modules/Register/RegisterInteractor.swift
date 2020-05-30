//
//  RegisterInteractor.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RegisterInteractorProtocol {
    
    func checkValid(login: String?) -> String?
    func checkValid(password: String?) -> String?
	func registrate(email: String, password: String, completion: @escaping AuthService.AuthResponse)
    func save(token: String)
}

class RegisterInteractor: RegisterInteractorProtocol {
    
    private let networkService = NetworkSettings.shared
	private let validateManager = ValidateManager()
    private let authService: AuthService = AuthServiceImplementation(
        with: KeychainDatabaseServiceImplementation.instance)
   	
	func registrate(email: String, password: String, completion: @escaping AuthService.AuthResponse) {
        authService.register(identity: email, password: password, completion: completion)
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


