//
//  FeedbackAssembler.swift
//  Legio
//
//  Created by Mikhail Semerikov on 29.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol FeedbackAssemblerProtocol: class {
    func assemble(with view: FeedbackView)
}

class FeedbackAssembler: FeedbackAssemblerProtocol {
    
    func assemble(with view: FeedbackView) {
        let router = FeedbackRouter(controller: view)
        let interactor = FeedbackInteractor()
        let presenter = FeedbackPresenter()
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
    }
    
}
