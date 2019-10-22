//
//  PresetInteractor.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol PresetInteractorProtocol {
    
    func saveData(data: PresetEntity)
    func getData(type: TypePreset) ->PresetEntity
    
}

class PresetInteractor: PresetInteractorProtocol {
    
    func saveData(data: PresetEntity) {
        // Куда-то сохраняем. Куда лучше?
        
        // тут 2 варианта,
        // 1 мы должны хранить это в синглтоне с данными текущего пользователя,
        // 2 мы должны эти данные переслать на сервер
        // неасчет первого и второго пока точно не понятно, в каком виде удем держать/передавать
    }
    
    // MARK : PresetInteractorDelegate
    
    func getData(type: TypePreset) -> PresetEntity {
        
        // Пока временно создам со стандартными парамметрами на 50%
        let middlePercentOfValue = 50
        
        let percentOfNumber: Double = Double(middlePercentOfValue / 100)
        let valueOfMinimumFontSize = 12.0
        let coefficientOfMaximumFontSize = 1.67
        let outOfCoefficient = 1.0
        
        let middleSize: Double = valueOfMinimumFontSize * (outOfCoefficient + (coefficientOfMaximumFontSize * percentOfNumber))
        
        let preset = PresetEntity(typePreset: type, percent: middlePercentOfValue, size: Float(middleSize))
        return preset
    }

}

