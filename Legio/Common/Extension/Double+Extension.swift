//
//  Double+Extension.swift
//  Legio
//
//  Created by Mikhail Semerikov on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

extension Double {

    func getStringValue(withFloatingPoints points: Int = 0) -> String {
        let valDouble = modf(self)
        let fractionalVal = (valDouble.1)
        if fractionalVal > 0 {
            return String(format: "%.*f", points, self)
        }
        return String(format: "%.0f", self)
    }
}
