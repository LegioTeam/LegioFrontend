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
    func auth(email: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void)
}

class AuthInteractor: AuthInteractorProtocol {
    private let validateManager = ValidateManager()
    var network = NetworkManager.shared
    
    func auth(email: String, password: String, completion: @escaping (_ userData: Success?,_ error: Error?) -> Void) {
        network.userAuth(login: email, password: password, completion: completion)
    }
    
    internal func checkValid(login: String?) -> String? {
        return validateManager.validate(email: login)
    }
    
    internal func checkValid(password: String?) -> String? {
        return validateManager.validate(password: password)
    }
    
}
