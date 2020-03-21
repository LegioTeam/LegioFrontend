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
    
    internal let baseUrlString: String = "https://legio.hntr.info/v1"
    
    internal var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1aXRlc3RlciIsImlkZW50aXR5IjoidWl0ZXN0ZXIiLCJpYXQiOjE1ODQyODE3OTUsImV4cCI6MTU4Njg3Mzc5NX0.xLYlMGGdNpKAsVKHIjucdXr8x6iXUX8PLa9Ihc_aKEA"
    
    private init() {}
    
    
}
