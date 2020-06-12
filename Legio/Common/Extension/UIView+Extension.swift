//
//  UIView+Extension.swift
//  Legio
//
//  Created by Mac on 10.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

extension UIView {
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    internal var nibName: String {
        return String(describing: type(of: self))
    }
    
}

//Gradient

extension UIView{

    func addBlackGradientLayerInForeground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{ $0.cgColor }
        self.layer.addSublayer(gradient)
    }
    
    func addBlackGradientLayerInBackground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{ $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
