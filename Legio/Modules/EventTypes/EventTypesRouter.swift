//
//  EventTypesRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesRouterProtocol: class {
	func showEvents()
    func showGeoRequest()
    func dismiss()
}

class EventTypesRouter: BaseRouter {
    
}

extension EventTypesRouter: EventTypesRouterProtocol {
	
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
