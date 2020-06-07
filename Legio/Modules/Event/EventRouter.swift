//
//  EventRouter.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventRouterProtocol: class {
    func showEventTypes()
    func showDetails(url: String)
}

final class EventRouter: BaseRouter { }

extension EventRouter: EventRouterProtocol {
    
    func showEventTypes() {
        guard let controller = UIStoryboard(name: "EventTypes", bundle: nil)
            .instantiateViewController(withIdentifier: EventTypesView.storyboardIdentifier) as? EventTypesView else { return }
        let assembler: EventTypesAssemblerProtocol = EventTypesAssembler()
        assembler.assemble(with: controller, needReturn: true)
        self.present(controller)
    }
    
    func showDetails(url: String) {
        let webVC = EventWebView()
        webVC.urlString = url
        self.show(webVC)
    }
}
