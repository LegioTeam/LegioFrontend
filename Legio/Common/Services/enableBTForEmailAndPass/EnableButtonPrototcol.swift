//
//  EnableButtonPrototcol.swift
//  Legio
//
//  Created by MIkkyMouse on 18/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EnableButtonPrototcol {
    func enableButton(actionTF: UITextField, textfield: [UITextField], alertLabel: [UILabel], alertAction: [UIProgressView], registerBT: UIButton)
    func validate(email: String?) -> String?
    func validate(password: String?) -> String?
}


