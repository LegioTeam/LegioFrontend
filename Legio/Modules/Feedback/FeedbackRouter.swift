//
//  FeedbackRouter.swift
//  Legio
//
//  Created by Mikhail Semerikov on 29.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol FeedbackRouterProtocol: class {
    func showEvent()
}

class FeedbackRouter: BaseRouter { }

extension FeedbackRouter: FeedbackRouterProtocol {
    
    func showEvent() {
        guard let controller = UIStoryboard(name: "Event", bundle: nil)
            .instantiateViewController(withIdentifier: EventView.storyboardIdentifier) as? EventView else { return }
        let assemler: EventAssemblerProtocol = EventAssembler()
        assemler.assemble(with: controller)
        self.show(controller)
    }
    
}
