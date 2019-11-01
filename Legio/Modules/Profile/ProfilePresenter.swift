//
//  ProfilePresenter.swift
//  Legio
//
//  Created by MIkkyMouse on 31/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol ProfilePresenterProtocol: class {
    func showStatic()
    func showPreset()
    func showEvent()
    func logOut()
}



class ProfilePresenter {
    
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol!
    var router: ProfileRouterProtocol!
    
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func showStatic() {
        router.showStatic()
        print("no active func")
    }
    
    func showPreset() {
        router.showPreset()
    }
    
    func showEvent() {
        router.showEvent()
    }
    
    func logOut() {
        print("no active func")
    }
    
    
    
}
