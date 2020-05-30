//
//  GeoRequestPresenter.swift
//  Legio
//
//  Created by Mac on 25.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit
import CoreLocation

/// Протокол презентера GeoRequestPresenter
protocol GeoRequestPresenterProtocol {
    
    /// Событие при нажатии Пропустить
    func didSkipTap()
    
    /// Событие при нажатии Включить
    func didGeoEnableTap()
}

final class GeoRequestPresenter {
    
    weak var view: GeoRequestViewProtocol?
    var router: GeoRequestRouterProtocol!
    var interactor: GeoRequestInteractorProtocol!
    var locationService: LocationService!
   
}

extension GeoRequestPresenter: GeoRequestPresenterProtocol {
    
    func didSkipTap() {
        router.showEvents()
    }
    
    func didGeoEnableTap() {
        locationService.delegate = self
        locationService.makeRequest()
    }
    
}

extension GeoRequestPresenter: LocationManagerDelegate {
    
    func locationManager(result: LocationManagerResult) {
        router.showEvents()
    }
    
    func locationManager(didUpdateLocations locations: [CLLocation]) {}
}

