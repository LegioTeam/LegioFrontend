//
//  InterestCellViewModel.swift
//  Legio
//
//  Created by Mac on 10.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

/// Модель интереса
struct InterestCellViewModel {
    
    private enum Constants {
        static let defaultCellWidth: CGFloat = 30
        static let defaultCellHeight: CGFloat = 50
        static let cellRightSpace: CGFloat = 20
    }
    
    /// Id интереса
    let id: Int
    
    /// Название интереса
    let name: String
    
    /// Выбран ли интерес
    var isSelected: Bool
    
    /// Размер ячейки
    let cellSize: CGSize
    
    init(id: Int, name: String, containerWidth: CGFloat) {
        self.id = id
        self.name = name
        self.isSelected = false
        self.cellSize = InterestCellViewModel.configureCellSize(
            name: name,
            containerWidth: containerWidth)
    }
    
    private static func configureCellSize(
        name: String,
        containerWidth: CGFloat) -> CGSize {
        
        let maxCellWidth: CGFloat = (containerWidth / 2) - 2
        
        let cellHeight = Constants.defaultCellHeight
        var cellWidth = Constants.defaultCellWidth
        
        let interestCell = InterestDefaultCell(
            frame: CGRect(
                x: 0,
                y: 0,
                width: containerWidth,
                height: cellHeight))
        
        interestCell.labelName.text = name
        interestCell.contentView.layoutIfNeeded()
        
        if (interestCell.viewMain.frame.width + Constants.cellRightSpace) < maxCellWidth {
            cellWidth = interestCell.viewMain.frame.width + Constants.cellRightSpace
        } else {
            cellWidth = maxCellWidth
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
 
