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
	func registrate(email: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void)
}

class RegisterInteractor: RegisterInteractorProtocol {
	private let validateManager = ValidateManager()
	private let networkManager = NetworkManager.shared
   	
	func registrate(email: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void) {
		networkManager.registrate(login: email, password: password, completion: completion)
	}
    
    internal func checkValid(login: String?) -> String? {
        return validateManager.validate(email: login)
    }
    
    internal func checkValid(password: String?) -> String? {
        return validateManager.validate(password: password)
    }
}


