//
//  DatabaseService.swift
//  Legio
//
//  Created by Mac on 30.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import KeychainSwift

/// Протокол хранения данных в приложении
protocol DatabaseService {
    func save(token: String)
    func getToken() -> String?
    
    func save(login: String, password: String)
    func getLogin() -> String?
    func getPassword() -> String?
}

final class KeychainDatabaseServiceImplementation: DatabaseService {
    
    private enum Keys {
        static let login = "login"
        static let password = "password"
        static let token = "token"
    }
    
    static let instance = KeychainDatabaseServiceImplementation()
    private init() {}
    
    
    // MARK: - save
    
    func save(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: Keys.token)
    }
    
    func save(login: String, password: String) {
        let keychain = KeychainSwift()
        keychain.set(login, forKey: Keys.login)
        keychain.set(password, forKey: Keys.password)
    }
    
    
    // MARK: - get
    
    func getToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(Keys.token)
    }
    
    func getLogin() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(Keys.login)
    }
    
    func getPassword() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(Keys.password)
    }
    
}
