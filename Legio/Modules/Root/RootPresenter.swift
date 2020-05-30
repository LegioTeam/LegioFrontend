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
	
}

extension RootPresenter: RootPresenterProtocol {
	
    func viewDidLoad() {
        LocationManager.sharedManager.isEnabled()
        enterWithoutLoginView()
    }
    
    private func enterWithoutLoginView() {
        let auth = AuthServiceImplementation()
        auth.signIn(identity: NetworkSettings.defaultLogin, password: NetworkSettings.defaultPassword) { [weak self] result in
            switch result {
            case .success(let profile):
                guard let token = profile.token else { return }
                self?.authInteractor.save(token: token)
                self?.router.showPreset()
                
            case .failure(let error):
                self?.view?.showError(title: "Что-то пошло не так", subtitle: error.localizedDescription)
            }
        }
    }
    
    private func enterDefault() {
        let keychain = KeychainSwift()
        guard let identity = keychain.get(Keys.identity),
            let password = keychain.get(Keys.password) else {
                router.showLoginMain()
                return
        }

        let auth = AuthServiceImplementation()
        auth.signIn(identity: identity, password: password) { [weak self] result in
            switch result {
            case .success(let profile):
                guard let token = profile.token else { return }
                self?.authInteractor.save(token: token)
                //self?.router.showEventTypes()
                self?.router.showPreset()

            case .failure(let error):
                self?.router.showLoginMain()
                self?.view?.showError(title: "Что-то пошло не так", subtitle: error.localizedDescription)
            }
        }
    }
}
