//
//  AuthService.swift
//  Legio
//
//  Created by Mac on 29.02.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol AuthService {
    
    /// Авторизация пользователя (не используется)
    func signIn(identity: String, password: String, completion: @escaping AuthResponse)
    
    /// Регистрация нового пользователя (не используется)
    func register(identity: String, password: String, completion: @escaping AuthResponse)
    
    /// Регистрация нового пользователя (без логина и пароля)
    func getToken(completion: @escaping TokenResponse)
}

extension AuthService {
    
    public typealias AuthResponse = (Result<UserProfile, Error>) -> Void
    public typealias TokenResponse = (Result<String, Error>) -> Void
}
