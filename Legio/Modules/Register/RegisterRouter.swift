//
//  RegisterRouter.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol RegisterRouterProtocol: class {
	func showSingIn()
}

class RegisterRouter: BaseRouter {
	
}

extension RegisterRouter: RegisterRouterProtocol {
	
	func showSingIn() {
		guard let controller = UIStoryboard(name: "Preset", bundle: nil)
            .instantiateViewController(withIdentifier: PresetView.storyboardIdentifier) as? PresetView else { return }
		self.present(controller)
	}
	
}
