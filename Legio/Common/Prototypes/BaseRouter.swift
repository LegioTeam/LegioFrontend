//
//  BaseRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class BaseRouter: NSObject {
	
	private weak var controller: UIViewController!
	
	required init(controller: UIViewController) {
		self.controller = controller
	}
	
	func show(_ controller: UIViewController) {
        controller.navigationItem.title = ""
		self.controller.show(controller, sender: nil)
        removeBackWord()
	}
	
	func present(_ controller: UIViewController) {
        controller.navigationItem.title = ""
		self.controller.present(controller, animated: true)
	}
    
    func presentFromLeft(_ controller: UIViewController, completion: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        controller.modalPresentationStyle = .fullScreen
        self.controller.view.window?.layer.add(transition, forKey: kCATransition)
        self.controller.present(controller, animated: false, completion: completion)
    }
	
	func setAsRoot(_ controller: UIViewController) {
        controller.navigationItem.title = ""
		UIApplication.shared.keyWindow?.rootViewController = controller
	}
    
    func dismiss() {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func removeBackWord() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        controller.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

	
}
