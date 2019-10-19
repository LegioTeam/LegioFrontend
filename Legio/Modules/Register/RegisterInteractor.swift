//
//  RegisterInteractor.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol RegisterInteractorProtocol {
	func registrate(email: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void)
}

class RegisterInteractor: RegisterInteractorProtocol {
	
	private let networkManager = NetworkManager.shared
   	
	func registrate(email: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void) {
		networkManager.registrate(login: email, password: password, completion: completion)
	}
}


