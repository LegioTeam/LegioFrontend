//
//  NetworkSettings.swift
//  Legio
//
//  Created by Mac on 01.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

class NetworkSettings {
    
    static var shared = NetworkSettings()
    
    static var defaultLogin = "login@login.com"
    
    static var defaultPassword = "prostopover"
    
    internal let baseUrlString: String = "https://legio.hntr.info/v1"
    
    internal var token: String = ""
    
    private init() {}
    
    
}
