//
//  EventTypesRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesRouterProtocol: class {
	func showEvent()
}

class EventTypesRouter: BaseRouter {
}

extension EventTypesRouter: EventTypesRouterProtocol {
	
	func showEvent() {
		guard let controller = UIStoryboard(name: "Event", bundle: nil)
			.instantiateViewController(withIdentifier: EventView.storyboardIdentifier) as? EventView else { return }
        let assemler: EventAssemblerProtocol = EventAssembler()
        assemler.assemble(with: controller)
		self.show(controller)
	}
}
