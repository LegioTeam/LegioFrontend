//
//  FeedbackPresenter.swift
//  Legio
//
//  Created by Mikhail Semerikov on 29.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import UserNotifications

protocol FeedbackPresenterProtocol: class {
    func tapButton(button: String)
}

class FeedbackPresenter {
    weak var view: FeedbackViewProtocol?
    var interactor: FeedbackInteractorProtocol!
    var router: FeedbackRouterProtocol!
//    var event: Event?
}

extension FeedbackPresenter: FeedbackPresenterProtocol {
    func tapButton(button: String) {
        switch button {
        case "Like":
            print("Like") //Отправка фидбэка на сервер
            router.showEvent()
        case "Dislike":
            print("Dislike") //Отправка фидбэка на сервер
            router.showEvent()
        case "Close":
            router.showEvent()
        default:
            print("Error")
        }
    }
}
