//
//  InterestCell.swift
//  Legio
//
//  Created by Mac on 10.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class InterestCell: UICollectionViewCell {
    
    private var widthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewMain: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.init(red: 233/255, green: 237/255, blue: 255/255, alpha: 1).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.darkText
        label.lineBreakMode = .byTruncatingMiddle
        return label
    }()
    
    let viewHeart: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "heart")
        view.isHidden = true
        return view
    }()
    
    let labelSelectedCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.isHidden = true
        return label
    }()
    
    
    func configure(viewModel: InterestCellViewModel) {
        
        labelName.text = viewModel.name
        
        if viewModel.isSelected {
            viewHeart.isHidden = false
            labelName.textColor = UIColor.white
            viewMain.backgroundColor = UIColor.legio.legioBlue
            
        } else {
            viewHeart.isHidden = true
            labelName.textColor = UIColor.darkText
            viewMain.backgroundColor = UIColor.white
        }
    }
    
    public func updateCell(width: CGFloat) {
        if let constraint = widthConstraint {
            NSLayoutConstraint.deactivate([constraint])
        }
        let constraint = self.contentView.widthAnchor.constraint(equalToConstant: width)
        NSLayoutConstraint.activate([constraint])
        self.widthConstraint = constraint
    }
    
}

extension InterestCell {
    
    private func setupViews() {
        self.contentView.addSubview(viewMain)
        self.contentView.addSubview(viewHeart)
        self.contentView.addSubview(labelSelectedCount)
        viewMain.addSubview(labelName)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            self.viewMain.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8),
            self.viewMain.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            self.viewMain.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            self.viewMain.heightAnchor.constraint(equalToConstant: 40),
            
            self.viewHeart.topAnchor.constraint(equalTo: self.viewMain.topAnchor, constant: -8),
            self.viewHeart.rightAnchor.constraint(equalTo: self.viewMain.rightAnchor, constant: 14),
            self.viewHeart.heightAnchor.constraint(equalToConstant: 30),
            self.viewHeart.widthAnchor.constraint(equalToConstant: 30),
            
            self.labelSelectedCount.centerXAnchor.constraint(equalTo: self.viewHeart.centerXAnchor, constant: 0),
            self.labelSelectedCount.centerYAnchor.constraint(equalTo: self.viewHeart.centerYAnchor, constant: -2),
            self.labelSelectedCount.heightAnchor.constraint(equalToConstant: 30),
            self.labelSelectedCount.widthAnchor.constraint(equalToConstant: 30),
               
            self.labelName.leftAnchor.constraint(equalTo: self.viewMain.leftAnchor, constant: 16),
            self.labelName.rightAnchor.constraint(equalTo: self.viewMain.rightAnchor, constant: -16),
            self.labelName.topAnchor.constraint(equalTo: self.viewMain.topAnchor, constant: 0),
            self.labelName.bottomAnchor.constraint(equalTo: self.viewMain.bottomAnchor, constant: 0)
        ])
    }
    
}



