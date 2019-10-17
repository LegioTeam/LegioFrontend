//
//  LoginMainView.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol LoginMainViewProtocol: class {
	func show(error: String)
}

class LoginMainView: UIViewController {
	
    
    
	var presenter: LoginMainPresenterProtocol!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.isHidden = true
	}
	
}

//MARK: - Actions
extension LoginMainView {
	
	@IBAction func registerButton(_ sender: UIButton) {
		presenter.registerTapped()
	}
	
	@IBAction func facebookButton(_ sender: Any) {
		presenter.facebookTapped()
	}
	
	@IBAction func vkontakteButton(_ sender: UIButton) {
		presenter.vkTapped()
	}
	
	@IBAction func authButton(_ sender: UIButton) {
		presenter.authTapped()
	}
}

extension LoginMainView: LoginMainViewProtocol {
	
	func show(error: String) {
		plugsAlert(title: error)
	}
}
