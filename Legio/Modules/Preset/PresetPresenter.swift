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
        
        view?.updateViews(preset: party, font: makeFont(fontSize: party.size))
        view?.updateViews(preset: nerdy, font: makeFont(fontSize: nerdy.size))
    }
    
    internal func updateData(percents: Int) {
        // party
            var party = PresetEntity(typePreset: .Party, percent: percents, size: 0)
            party = calculatePreset(preset: party)
            interactor?.saveData(data: party)
            view?.updateViews(preset: party, font: makeFont(fontSize: party.size))
        // nerdy
            var nerdy = PresetEntity(typePreset: .Nerdy, percent: 100 - percents, size: 0)
            nerdy = calculatePreset(preset: nerdy)
            interactor?.saveData(data: nerdy)
            view?.updateViews(preset: nerdy, font: makeFont(fontSize: nerdy.size))
    }
    
    internal func showEventTypesTapped() {
        router.showEventTypes()
    }
    
    internal func calculatePreset(preset: PresetEntity) -> PresetEntity {
        
        let percentOfNumber = Double(preset.percent) / 100
        let valueOfMinimumFontSize = 12.0
        let coefficientOfMaximumFontSize = 1.67
        let outOfCoefficient = 1.0
        
        let size: Double = valueOfMinimumFontSize * (outOfCoefficient + (coefficientOfMaximumFontSize * percentOfNumber))
        
        var presetToReturn = preset
        presetToReturn.size = Float(size)
        return presetToReturn
    }
    
    internal func makeFont(fontSize: Float) -> UIFont {
        return UIFont(name:"ArialRoundedMTBold" , size: CGFloat(fontSize))!
    }
}

