//
//  InterestCell.swift
//  Legio
//
//  Created by Mac on 10.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class InterestCell: UICollectionViewCell {
    
    private enum Constants {
        static let maxCellWidth: CGFloat = (UIScreen.main.bounds.width - 32) / 2 - 2
    }
    
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
        view.layer.borderColor = UIColor.legio.legioBlue.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
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
            labelName.textColor = UIColor.white
            viewMain.backgroundColor = UIColor.legio.legioBlue
            
        } else {
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
            viewMain.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            viewMain.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 2),
            viewMain.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            viewMain.heightAnchor.constraint(equalToConstant: 44),
            viewMain.widthAnchor.constraint(equalToConstant: Constants.maxCellWidth),
            
            viewHeart.topAnchor.constraint(equalTo: viewMain.topAnchor, constant: -8),
            viewHeart.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: 10),
            viewHeart.heightAnchor.constraint(equalToConstant: 30),
            viewHeart.widthAnchor.constraint(equalToConstant: 30),
            
            labelSelectedCount.centerXAnchor.constraint(equalTo: viewHeart.centerXAnchor, constant: 0),
            labelSelectedCount.centerYAnchor.constraint(equalTo: viewHeart.centerYAnchor, constant: -2),
            labelSelectedCount.heightAnchor.constraint(equalToConstant: 30),
            labelSelectedCount.widthAnchor.constraint(equalToConstant: 30),
               
            labelName.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: 16),
            labelName.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: -16),
            labelName.topAnchor.constraint(equalTo: viewMain.topAnchor, constant: 0),
            labelName.bottomAnchor.constraint(equalTo: viewMain.bottomAnchor, constant: 0)
        ])
    }
    
}



