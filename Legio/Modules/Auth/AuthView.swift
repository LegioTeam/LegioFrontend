//
//  Auth.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol AuthViewProtocol {
    
}

class AuthView: UIViewController {
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
   
    @IBOutlet weak var labelFalseEmail: UILabel!
    @IBOutlet weak var errorEmailView: UIProgressView!
    
    @IBOutlet weak var labelFalsePassword: UILabel!
    @IBOutlet weak var errorPasswordView: UIProgressView!
    
    @IBOutlet weak var sigInButtonPressed: UIButton!
    
    private let titleText = "Auth"
    
    var router: AuthRouterProtocol?
    let chekLoginPasswprd = EnableButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        router = AuthRouter(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textFieldLogin.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Actions
extension AuthView {
    
    
    
    @IBAction func buttonSingInTapped(_ sender: Any) {
        plugsAlert(title: "This feature is not available yet")
    }
    
    @IBAction func buttonForgotTapped(_ sender: Any) {
        plugsAlert(title: "This feature is not available yet")
        //router?.showForgot()
    }
    
    
    
}

extension AuthView {
    
    private func configureViews() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = titleText
        self.sigInButtonPressed.isUserInteractionEnabled = false
        self.sigInButtonPressed.backgroundColor = #colorLiteral(red: 0.6165822148, green: 0.8022601008, blue: 0.9945415854, alpha: 1)
        self.labelFalseEmail.isHidden = true
        self.labelFalsePassword.isHidden = true
        self.errorEmailView.progress = 0.0
        self.errorPasswordView.progress = 0.0
        self.textFieldLogin.delegate = self
        self.textFieldPassword.delegate = self
    }
    
}
