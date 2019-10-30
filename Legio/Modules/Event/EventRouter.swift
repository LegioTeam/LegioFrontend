//
//  EventRouter.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventRouterProtocol: class {
    func showPreset()
    func showDetails(url: String)
    func showParty()
    func showNerdy()
}

class EventRouter: BaseRouter { }

extension EventRouter: EventRouterProtocol {
    
    func showPreset() {
        guard let controller = UIStoryboard(name: "Preset", bundle: nil)
            .instantiateViewController(withIdentifier:  PresetView.storyboardIdentifier) as? PresetView else {
                return
        }
        self.show(controller)
    }
    
    func showDetails(url: String) {
        let webVC = EventWebView()
        webVC.urlString = url
        self.show(webVC)
    }
    
    func showParty() {
        guard let controller = UIStoryboard(name: "Event", bundle: nil)
            .instantiateViewController(withIdentifier: EventView.storyboardIdentifier) as? EventView else { return }
        let assembler: EventAssemblerProtocol = EventAssembler()
        assembler.assembleFromButton(with: controller)
        self.presentFromLeft(controller, completion: nil)
    }
    
    func showNerdy() {
        guard let controller = UIStoryboard(name: "Event", bundle: nil)
            .instantiateViewController(withIdentifier: EventView.storyboardIdentifier) as? EventView else { return }
        let assembler: EventAssemblerProtocol = EventAssembler()
        assembler.assembleFromButton(with: controller)
        self.show(controller)
    }
    
}
