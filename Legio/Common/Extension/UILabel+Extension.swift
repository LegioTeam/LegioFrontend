//
//  UILabel+Extension.swift
//  Legio
//
//  Created by Mikhail Semerikov on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

extension UILabel {
    func set(image: UIImage, with textBefore: String, and textAfter: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        let mutableAttributedString = NSMutableAttributedString()
        let attachmentStr = NSAttributedString(attachment: attachment)
        let textStringBefore = NSAttributedString(string: textBefore,
                                                  attributes: [.font: self.font!])
        let spaceText = NSAttributedString(string: " ",
                                           attributes: [.font: self.font!])
        let separator = NSAttributedString(string: "•",
                                           attributes: [.font: self.font!, .foregroundColor: UIColor.legio.legioGray])
        let textStringAfter = NSAttributedString(string: textAfter,
                                                 attributes: [.font: self.font!, .foregroundColor: UIColor.legio.legioGray])
        mutableAttributedString.append(textStringBefore)
        mutableAttributedString.append(spaceText)
        mutableAttributedString.append(separator)
        mutableAttributedString.append(spaceText)
        mutableAttributedString.append(attachmentStr)
        mutableAttributedString.append(spaceText)
        mutableAttributedString.append(textStringAfter)
        self.attributedText = mutableAttributedString
    }
}
