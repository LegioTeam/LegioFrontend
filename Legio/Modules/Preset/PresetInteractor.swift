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
    }
    
    // MARK : PresetInteractorDelegate
    
    func getData(type: TypePreset) -> PresetEntity {
        
        // Пока временно создам со стандартными парамметрами на 50%
        let preset = PresetEntity(typePreset: type, percent: 50, size: 22.02)
        return preset
    }

}

