//
//  PresetSlider.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class PresetSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
       var newBounds = super.trackRect(forBounds: bounds)
       newBounds.size.height = 16

        //self.maximumTrackTintColor = UIColor(hex: "#0075FF")
        //self.minimumTrackTintColor = UIColor(hex: "##FF007A")

       return newBounds
    }

}

