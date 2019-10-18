//
//  RegisterView.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol RegisterViewProtocol: class {
	func show(error: String)
}

class RegisterView: UIViewController {
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var registerButtonPressed: UIButton!
    @IBOutlet weak var labelFalseEmail: UILabel!
    @IBOutlet weak var errorEmailView: UIProgressView!
    @IBOutlet weak var labelFalsePassword: UILabel!
    @IBOutlet weak var errorPasswordView: UIProgressView!
    
	var presenter: RegisterPresenterProtocol!
    var router: RegisterRouterProtocol!
	let chekLoginPasswprd = EnableButton()
    
	private let titleText = "Register"
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureViews()
	}
	
    override func viewWillAppear(_ animated: Bool) {
        textFieldLogin.becomeFirstResponder()
    }
    
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
}

//MARK: - Actions
extension RegisterView {
	
	@IBAction func buttonSingInTapped(_ sender: Any) {
		presenter.registrateTapped(email: textFieldLogin.text,
							 password: textFieldPassword.text)
	}
	
}

extension RegisterView: RegisterViewProtocol {
	
	func show(error: String) {
		plugsAlert(title: error)
	}
}

extension RegisterView {
	
	private func configureViews() {
		self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = titleText
        self.registerButtonPressed.isUserInteractionEnabled = false
        self.registerButtonPressed.backgroundColor = #colorLiteral(red: 0.6165822148, green: 0.8022601008, blue: 0.9945415854, alpha: 1)
        self.labelFalseEmail.isHidden = true
        self.labelFalsePassword.isHidden = true
        self.errorEmailView.progress = 0.0
        self.errorPasswordView.progress = 0.0
        self.textFieldLogin.delegate = self
        self.textFieldPassword.delegate = self
	}
	
}


