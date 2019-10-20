//
//  CustomButton.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol CustomButtonProtocol: class {
    var enabledBackgroundColor: UIColor { get }
    var disabledBackgroundColor: UIColor { get }
    func update(isEnabled: Bool)
}

class CustomButton: UIButton, CustomButtonProtocol {
  
    var enabledBackgroundColor: UIColor {
        return #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
    }
    
    var disabledBackgroundColor: UIColor {
        return #colorLiteral(red: 0.6165822148, green: 0.8022601008, blue: 0.9945415854, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        update(isEnabled: self.isEnabled)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        update(isEnabled: self.isEnabled)
    }
    
    func update(isEnabled: Bool) {
        self.isEnabled = isEnabled
        self.backgroundColor = isEnabled
            ? enabledBackgroundColor
            : disabledBackgroundColor
    }
    
    
}
