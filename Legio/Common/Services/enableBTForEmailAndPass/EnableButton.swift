//
//  EnableButton.swift
//  Legio
//
//  Created by MIkkyMouse on 18/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class EnableButton: EnableButtonPrototcol {
    
    func enableButton(actionTF: UITextField, textfield: [UITextField], alertLabel: [UILabel], alertAction: [UIProgressView], registerBT: UIButton) {
        
        
        if actionTF.placeholder == "Электропочта" {
            // проверяем электроную почту на валидность
            guard let email = textfield[0].text else { return }
            if validate(email: email) != nil {
                alertLabel[0].isHidden = true
                alertAction[0].progress = 0.0
                let checkMark = UIImage(named: "checkMarkTF")
                let checkMarkImageView = UIImageView(image: checkMark)
                checkMarkImageView.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
                textfield[0].rightView = checkMarkImageView
                textfield[0].rightViewMode = .always
            } else {
                alertLabel[0].isHidden = false
                alertAction[0].progress = 1.0
                textfield[0].rightViewMode = .never
            }
        } else {
            // проверяем пароль на валидность
            guard let password = textfield[1].text else { return }
            if validate(password: password) != nil {
                alertLabel[1].isHidden = true
                alertAction[1].progress = 0.0
                let checkMark = UIImage(named: "checkMarkTF")
                let checkMarkImageView = UIImageView(image: checkMark)
                checkMarkImageView.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
                textfield[1].rightView = checkMarkImageView
                textfield[1].rightViewMode = .always
            } else {
                alertLabel[1].isHidden = false
                alertAction[1].progress = 1.0
                textfield[1].rightViewMode = .never
            }
        }
        
        // переводим курсор в зависимости от введенных данных
        if actionTF.placeholder == "Электропочта" {
            textfield[1].becomeFirstResponder()
        } else {
            textfield[0].becomeFirstResponder()
        }
        
        // устонавливаем активность кнопки регестрации
        if (validate(email: textfield[0].text) != nil) && (validate(password: textfield[1].text) != nil) {
            registerBT.isUserInteractionEnabled = true
            registerBT.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        } else {
            registerBT.isUserInteractionEnabled = false
            registerBT.backgroundColor = #colorLiteral(red: 0.6165822148, green: 0.8022601008, blue: 0.9945415854, alpha: 1)
        }
    }
    
    func validate(email: String?) -> String? {
        guard let email = email,
            email.contains("@"),
            email.count > 5 else {
                return nil
        }
        for index in 0..<email.count {
            let emailArray = Array(email)
            if emailArray[index] == "@" {
                for indexTwo in index..<email.count {
                    if emailArray[indexTwo] == "." {
                        return email
                    }
                }
            }
        }
        return nil
    }
    
    func validate(password: String?) -> String? {
        guard let password = password,
            password.count > 5 else {
                return nil
        }
        return password
    }
    
    
}
