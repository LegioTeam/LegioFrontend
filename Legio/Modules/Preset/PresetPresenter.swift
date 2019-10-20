//
//  PresetPresenter.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol PresetPresenterProtocol {
    func setupData()
    func updateData(percents: Int)
    //func getData() ->PresetEntity
    //func setData(data: PresetEntity)
    func calculatePreset(preset: PresetEntity) ->PresetEntity
    func showEventTypesTapped()
}

class PresetPresenter: PresetPresenterProtocol {
    
    weak var view: PresetView?
    var interactor: PresetInteractor!
    var router: PresetRouter!
    
    internal func setupData() {
        guard var party = interactor?.getData(type: .Party),
            var nerdy = interactor?.getData(type: .Nerdy) else {
            return
        }
        
        party = calculatePreset(preset: party)
        nerdy = calculatePreset(preset: nerdy)
        
        view?.updateViews(preset: party)
        view?.updateViews(preset: nerdy)
    }
    
    internal func updateData(percents: Int) {
        // party
            var party = PresetEntity(typePreset: .Party, percent: percents, size: 0)
            party = calculatePreset(preset: party)
            interactor?.saveData(data: party)
            view?.updateViews(preset: party)
        // nerdy
            var nerdy = PresetEntity(typePreset: .Nerdy, percent: 100 - percents, size: 0)
            nerdy = calculatePreset(preset: nerdy)
            interactor?.saveData(data: nerdy)
            view?.updateViews(preset: nerdy)
    }
    
    internal func showEventTypesTapped() {
        router.showEventTypes()
    }
    
    internal func calculatePreset(preset: PresetEntity) -> PresetEntity {
        let size: Double = Double(12 * (1 + (1.67 * (Double(preset.percent) / 100))))
        var presetToReturn = preset
        presetToReturn.size = Float(size)
        return presetToReturn
    }
    
}

