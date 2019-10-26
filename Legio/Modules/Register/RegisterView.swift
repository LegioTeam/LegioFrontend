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
    func updateButtonRegister(isEnabled: Bool)
    func updateLoginAlert(isHidden: Bool)
    func updateLoginProgressBar(progress: Float)
    func updateLoginSuccess(image: UIImage?)
    func updatePasswordAlert(isHidden: Bool)
    func updatePasswordProgressBar(progress: Float)
    func updatePasswordSuccess(image: UIImage?)
}

class RegisterView: UIViewController {
	
	@IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var labelFalseEmail: UILabel!
    @IBOutlet weak var errorEmailView: UIProgressView!
    private var imageViewLoginSuccess = UIImageView()
    
	@IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelFalsePassword: UILabel!
    @IBOutlet weak var errorPasswordView: UIProgressView!
    private var imageViewPasswordSuccess = UIImageView()
    
    @IBOutlet weak var buttonRegister: CustomButton!
    
	var presenter: RegisterPresenterProtocol!
    
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
		presenter.registrateTapped()
	}
	
    @objc func loginChanged(_ textField: UITextField) {
        self.presenter.changed(login: textField.text)
    }
    
    @objc func passwordChanged(_ textField: UITextField) {
        self.presenter.changed(password: textField.text)
    }
    
}

extension RegisterView: RegisterViewProtocol {
    
	func show(error: String) {
		plugsAlert(title: error)
	}
    
    func updateButtonRegister(isEnabled: Bool) {
        self.buttonRegister.update(isEnabled: isEnabled)
    }
    
    func updateLoginAlert(isHidden: Bool) {
        self.labelFalseEmail.isHidden = isHidden
    }
    
    func updateLoginProgressBar(progress: Float) {
        self.errorEmailView.progress = progress
    }
    
    func updateLoginSuccess(image: UIImage?) {
        imageViewLoginSuccess.image = image
    }
    
    func updatePasswordAlert(isHidden: Bool) {
       self.labelFalsePassword.isHidden = isHidden
    }
    
    func updatePasswordProgressBar(progress: Float) {
         self.errorPasswordView.progress = progress
    }
    
    func updatePasswordSuccess(image: UIImage?) {
        imageViewPasswordSuccess.image = image
    }
    
}

extension RegisterView {
	
	private func configureViews() {
        self.navigationController?.navigationBar.isHidden = false
		self.navigationItem.title = titleText
        self.labelFalseEmail.isHidden = true
        self.labelFalsePassword.isHidden = true
        self.errorEmailView.progress = 0.0
        self.errorPasswordView.progress = 0.0
        configureTextFields()
	}
    
    private func configureTextFields() {
        textFieldLogin.addTarget(self, action: #selector(self.loginChanged(_:)), for: UIControl.Event.editingChanged)
        imageViewLoginSuccess = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
        textFieldLogin.rightView = imageViewLoginSuccess
        textFieldLogin.rightViewMode = .always
        imageViewLoginSuccess.contentMode = .scaleAspectFit
        
        textFieldPassword.addTarget(self, action: #selector(self.passwordChanged(_:)), for: UIControl.Event.editingChanged)
        imageViewPasswordSuccess = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
        textFieldPassword.rightView = imageViewPasswordSuccess
        textFieldPassword.rightViewMode = .always
        imageViewPasswordSuccess.contentMode = .scaleAspectFit
    }
    
}



