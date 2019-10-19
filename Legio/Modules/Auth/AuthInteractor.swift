//
//  AuthInteractor.swift
//  Legio
//
//  Created by MIkkyMouse on 19/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthInteractorProtocol {
    func auth(email: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void)
}

class AuthInteractor: AuthInteractorProtocol {
    
    var network = NetworkManager.shared
    func auth(email: String, password: String, completion: @escaping (_ userData: Success?,_ error: Error?) -> Void) {
        network.userAuth(login: email, password: password, completion: completion)
    }
}
