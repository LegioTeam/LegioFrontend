//
//  File.swift
//  Legio
//
//  Created by MIkkyMouse on 19/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

extension AuthView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chekLoginPasswprd.enableButton(actionTF: textField, textfield: [textFieldLogin, textFieldPassword], alertLabel: [labelFalseEmail, labelFalsePassword], alertAction: [errorEmailView, errorPasswordView], registerBT: sigInButtonPressed)
        return true
    }
}
