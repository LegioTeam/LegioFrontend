//
//  Float+Extention.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

extension Float {
    func convertToPercent() ->Int {
        let calculated = self * 100
        return Int(calculated)
    }
}
