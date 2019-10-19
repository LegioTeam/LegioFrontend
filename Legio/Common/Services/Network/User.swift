//
//  User.swift
//  Legio
//
//  Created by MIkkyMouse on 12/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation


class UserRegister: Decodable {

	static var userData = UserRegister()
    
    private init() {}
    var name: String?
    var token: String?
    
    
}

var userData = UserRegister.userData

// создаем класс для получения данных Json
class Success: Codable {
    var success: UserData
}

class UserData: Codable {
    var token: String?
}
