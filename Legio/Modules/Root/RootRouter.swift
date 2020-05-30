//
//  RootRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol RootRouterProtocol: class {
	func showLoginMain()
    func showEventTypes()
    func showPreset()
    func showEvents()
    func showGeoRequest()
}

class RootRouter: BaseRouter {
	
}

extension RootRouter: RootRouterProtocol {
    
    func showLoginMain() {
        guard let controller = UIStoryboard(name: "LoginMain", bundle: nil)
			.instantiateViewController(withIdentifier:  LoginMainView.storyboardIdentifier) as? LoginMainView else {
				return
		}
		let assembler: LoginMainAssemblerProtocol = LoginMainAssembler()
		assembler.assemble(with: controller)
        self.show(controller)
    }
    
    func showEventTypes() {
        guard let controller = UIStoryboard(name: "EventTypes", bundle: nil)
            .instantiateViewController(withIdentifier: EventTypesView.storyboardIdentifier) as? EventTypesView else { return }
        let assembler: EventTypesAssemblerProtocol = EventTypesAssembler()
        assembler.assemble(with: controller)
        self.show(controller)
    }
    
    func showPreset() {
        guard let controller = UIStoryboard(name: "Preset", bundle: nil)
            .instantiateViewController(withIdentifier: PresetView.storyboardIdentifier) as? PresetView else { return }
        let assembler: PresetAssemblerProtocol = PresetAssembler()
        assembler.assemble(with: controller)
        self.show(controller)
    }
    
    func showEvents() {
        guard let controller = UIStoryboard(name: "Event", bundle: nil)
            .instantiateViewController(withIdentifier: EventView.storyboardIdentifier) as? EventView else { return }
        let assemler: EventAssemblerProtocol = EventAssembler()
        assemler.assemble(with: controller)
        self.show(controller)
    }
    
    func showGeoRequest() {
        guard let controller = UIStoryboard(name: "GeoRequest", bundle: nil)
            .instantiateViewController(withIdentifier: GeoRequestView.storyboardIdentifier) as? GeoRequestView else { return }
        let assemler: GeoRequestAssemblerProtocol = GeoRequestAssembler()
        assemler.assemble(with: controller)
        self.show(controller)
    }
    
}
