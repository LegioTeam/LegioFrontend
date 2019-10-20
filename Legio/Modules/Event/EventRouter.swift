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
    
}

