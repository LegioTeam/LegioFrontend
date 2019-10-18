//
//  PresetView.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol PresetViewProtocol {
	
}

class PresetView: UIViewController {
	
	var router: PresetRouterProtocol?
	private let titleText = "Preset"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = titleText
		router = PresetRouter(controller: self)
	}
	
}

//MARK: - Actions
extension PresetView {
	
	@IBAction func buttonNextTapped(_ sender: Any) {
		router?.showEventTypes()
	}
	
}


