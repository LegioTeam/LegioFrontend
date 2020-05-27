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
        static let defaultCellWidth: CGFloat = (UIScreen.main.bounds.width - 32) / 2 - 2
        static let defaultCellHeight: CGFloat = 46
        static let cellRightSpace: CGFloat = 2
        
        static let defaultSize = CGSize(width: defaultCellWidth, height: defaultCellHeight)
    }
    
    /// Id интереса
    let id: Int
    
    /// Название интереса
    let name: String
    
    /// Выбран ли интерес
    var isSelected: Bool
    
    /// Размер ячейки
    let cellSize: CGSize
    
    init(id: Int, name: String, isSelected: Bool, containerWidth: CGFloat) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
        self.cellSize = InterestCellViewModel.configureCellSize(
            name: name,
            containerWidth: containerWidth)
    }
    
    private static func configureCellSize(
        name: String,
        containerWidth: CGFloat) -> CGSize {
        
        return Constants.defaultSize
    }
    
}
 
