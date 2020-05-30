//
//  GeoRequestRouter.swift
//  Legio
//
//  Created by Mac on 25.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol GeoRequestRouterProtocol: class {
    func showEvents()
}

final class GeoRequestRouter: BaseRouter { }

extension GeoRequestRouter: GeoRequestRouterProtocol {
    
    func showEvents() {
        guard let controller = UIStoryboard(name: "Event", bundle: nil)
            .instantiateViewController(withIdentifier: EventView.storyboardIdentifier) as? EventView else { return }
        let assemler: EventAssemblerProtocol = EventAssembler()
        assemler.assemble(with: controller)
        self.show(controller)
    }
    
}

