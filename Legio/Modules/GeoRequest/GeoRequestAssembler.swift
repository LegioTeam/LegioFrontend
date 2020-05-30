//
//  GeoRequestAssembler.swift
//  Legio
//
//  Created by Mac on 25.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol GeoRequestAssemblerProtocol {
    func assemble(with view: GeoRequestView)
}

final class GeoRequestAssembler: GeoRequestAssemblerProtocol {
    
    func assemble(with view: GeoRequestView) {
        let router = GeoRequestRouter(controller: view)
        let interactor = GeoRequestInteractor()
        
        let presenter = GeoRequestPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.locationService = LocationManager.sharedManager
        
        view.presenter = presenter
    }

}
