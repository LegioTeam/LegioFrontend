//
//  RootPresenter.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import KeychainSwift

protocol RootPresenterProtocol: class {
	func viewDidLoad()
}

class RootPresenter {
	weak var view: RootViewProtocol?
	var interactor: RootInteractorProtocol!
    var authInteractor: AuthInteractorProtocol!
	var router: RootRouterProtocol!
    
    /// Переменная отвечающая за состояние работы геолокации
    private var isLocationEnabled: Bool = false
}

extension RootPresenter: RootPresenterProtocol {
    
    private enum Texts {
        static let errorTitle = "Ошибка"
    }
    
    
	
    func viewDidLoad() {
        isLocationEnabled = LocationManager.sharedManager.isEnabled()
        checkIsAuthorized()
    }
    
    private func checkIsAuthorized() {
        if interactor.isAuthorized() {
            router.showEvents()
        } else {
            signIn()
        }
    }
    
    private func signIn() {
       
        interactor.signIn { [weak self] error in
            
            guard let error = error else {
                /// Добавим проверку, если у него есть интересы, значит уже авторизовывался
                self?.checkInterests()
                return
            }
            
            self?.view?.showError(title: Texts.errorTitle, subtitle: error.localizedDescription)
        }
    }
    
    private func checkInterests() {
        
        interactor.haveInterests { [weak self] haveInterests in
            if haveInterests {
                self?.checkLocationEnable()
            } else {
                self?.router.showPreset()
            }
        }
    }
    
    private func checkLocationEnable() {
        if isLocationEnabled {
            router.showEvents()
        } else {
            router.showGeoRequest()
        }
    }
    
}
