//
//  GeoRequestView.swift
//  Legio
//
//  Created by Mac on 25.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit
import NotificationBannerSwift

protocol GeoRequestViewProtocol: class {

}

final class GeoRequestView: UIViewController {
    
    private enum Constants {
        static let section: Int = 0
        static let cellIdentifier: String = "InterestCell"
    }
    
    var presenter: GeoRequestPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar(state: .onlyBackButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupReturnToPreviousViewController()
    }
    
}

extension GeoRequestView: GeoRequestViewProtocol {
    
    func showError(title: String, subtitle: String) {
        showNotificationBanner(title: title, subtitle: subtitle, style: .warning)
    }
    
    
}

//MARK: - Actions
extension GeoRequestView {
    
    @IBAction func didGeoEnableTap(_ sender: Any) {
        presenter.didGeoEnableTap()
    }
    
    @IBAction func didButtonSkipTap(_ sender: Any) {
        presenter.didSkipTap()
    }
    
}
