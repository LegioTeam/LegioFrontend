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
	}
	
	func present(_ controller: UIViewController) {
        controller.navigationItem.title = ""
		self.controller.present(controller, animated: true)
	}
	
	func setAsRoot(_ controller: UIViewController) {
        controller.navigationItem.title = ""
		UIApplication.shared.keyWindow?.rootViewController = controller
	}
	
}
