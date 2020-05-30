//
//  RootView.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import NotificationBannerSwift

protocol RootViewProtocol: class {
	func showError(title: String, subtitle: String)
}

class RootView: UIViewController {
	
	private let assembler: RootAssemblerProtocol = RootAssembler()
	var presenter: RootPresenterProtocol!
    
    private lazy var reloadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.legio.legioBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.titleLabel?.font = UIFont(name: "SFUIText-Semibold", size: 20)
        button.addTarget(self, action: #selector(didReloadButtonTap), for: .touchUpInside)
        return button
    }()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        assembler.assemble(with: self)
        configureViews()
		presenter.viewDidLoad()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar(state: .hide)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupReturnToPreviousViewController()
    }
    
    @objc private func didReloadButtonTap() {
        reloadButton.alpha = 0.5
        presenter.viewDidLoad()
    }
    
    private func configureViews() {
        view.addSubview(reloadButton)
        NSLayoutConstraint.activate([
            reloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            reloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            reloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            reloadButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}

extension RootView: RootViewProtocol {
    
    func showError(title: String, subtitle: String) {
        showNotificationBanner(title: title, subtitle: subtitle, style: .warning)
        reloadButton.alpha = 1
        reloadButton.isHidden = false
    }
}
