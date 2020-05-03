//
//  Auth.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthViewProtocol: class {
    func errorData()
    func updateButtonLogin(isEnabled: Bool)
    func updateLoginAlert(isHidden: Bool)
    func updateLoginProgressBar(progress: Float)
    func updateLoginSuccess(image: UIImage?)
    func updatePasswordAlert(isHidden: Bool)
    func updatePasswordProgressBar(progress: Float)
    func updatePasswordSuccess(image: UIImage?)
}

class AuthView: UIViewController {
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var labelFalseEmail: UILabel!
    @IBOutlet weak var errorEmailView: UIProgressView!
    private var imageViewLoginSuccess = UIImageView()
    
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelFalsePassword: UILabel!
    @IBOutlet weak var errorPasswordView: UIProgressView!
    private var imageViewPasswordSuccess = UIImageView()
    
    @IBOutlet weak var buttonLogin: CustomButton!
    
    var presenter: AuthPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldLogin.becomeFirstResponder()
        self.configureNavigationBar(state: .onlyBackButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackToViewControllerInStack()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Actions
extension AuthView {
    
    @IBAction func buttonSingInTapped(_ sender: Any) {
        presenter.authTapped()
    }
    
    @IBAction func buttonForgotTapped(_ sender: Any) {
        plugsAlert(title: "This feature is not available yet")
    }
    
    @objc func loginChanged(_ textField: UITextField) {
        self.presenter.changed(login: textField.text)
    }
    
    @objc func passwordChanged(_ textField: UITextField) {
        self.presenter.changed(password: textField.text)
    }
    
}

extension AuthView: AuthViewProtocol {
    
    func errorData() {
        let alert = UIAlertController(title: "Error", message: "Проверьте введенные данные", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func updateButtonLogin(isEnabled: Bool) {
        self.buttonLogin.update(isEnabled: isEnabled)
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

//MARK: - ConfigureData
extension AuthView {
    
    private func configureViews() {
        self.navigationController?.navigationBar.isHidden = false
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
        textFieldLogin.delegate = self
        
        textFieldPassword.addTarget(self, action: #selector(self.passwordChanged(_:)), for: UIControl.Event.editingChanged)
        imageViewPasswordSuccess = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
        textFieldPassword.rightView = imageViewPasswordSuccess
        textFieldPassword.rightViewMode = .always
        imageViewPasswordSuccess.contentMode = .scaleAspectFit
        textFieldPassword.delegate = self
    }
    
}

extension AuthView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLogin {
            textFieldPassword.becomeFirstResponder()
            return false
        } else {
            self.view.endEditing(true)
            return true
        }
    }
    
}
