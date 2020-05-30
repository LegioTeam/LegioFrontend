//
//  EmptyEventView.swift
//  Legio
//
//  Created by Mac on 29.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

class EmptyEventCardView: UIView {
    
    private enum Texts {
        static let title = "На сегодня событий больше нет(("
    }
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configure(viewModel: EventViewModel) {
        titleLabel.text = viewModel.name
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(self.nibName, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = frame
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        titleLabel.text = Texts.title
    }
    
}
