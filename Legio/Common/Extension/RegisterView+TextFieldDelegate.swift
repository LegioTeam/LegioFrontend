//
//  RegisterView+TextFieldDelegate.swift
//  Legio
//
//  Created by MIkkyMouse on 16/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

extension RegisterView: UITextFieldDelegate {
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        presenter.enableButton(actionTF: textField, textfield: [textFieldLogin, textFieldPassword], alertLabel: [labelFalseEmail, labelFalsePassword], alertAction: [errorEmailView, errorPasswordView], registerBT: registerButtonPressed)
        
        return true
 
    }
    
    
}

