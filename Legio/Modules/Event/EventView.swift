//
//  EventView.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import NotificationBannerSwift

protocol EventViewProtocol: class {
    func showError(title: String, subtitle: String)
    func showEvents(viewModels: [EventViewModel])
    func showLiked(title: String, subtitle: String)
}

final class EventView: UIViewController {
    
    @IBOutlet weak var eventsContainerView: EventsContainerView!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet weak var likeDislikeButtons: UIStackView!
    @IBOutlet weak var bottomConstraintStackView: NSLayoutConstraint!
    
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
    
    var presenter: EventPresenterProtocol!
    var mainEvent = true
    
    private var isHiddenBottomButtons = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(state: .hide)
        updateStatusBackground(isDefault: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateStatusBackground(isDefault: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension EventView: EventViewProtocol {
    
    func showError(title: String, subtitle: String) {
        updateLikeButtonsAlpha(needHide: true)
        showNotificationBanner(title: title, subtitle: subtitle, style: .warning)
        reloadButton.alpha = 1
        reloadButton.isHidden = false
    }
    
    func showEvents(viewModels: [EventViewModel]) {
        reloadButton.isHidden = true
        
        if viewModels.count > 1 {
            likeButton.isEnabled = true
            dislikeButton.isEnabled = true
            updateLikeButtonsAlpha(needHide: false, withAnimation: false)
            
        } else {
            updateLikeButtonsAlpha(needHide: true, withAnimation: false)
        }
        eventsContainerView.configure(viewModels: viewModels)
    }
    
    func showLiked(title: String, subtitle: String) {
        showNotificationBanner(
            title: title,
            subtitle: subtitle,
            style: .success)
        
        updateLikeButtonsAlpha(needHide: true, withAnimation: true)
    }
}

// MARK: - Actions

extension EventView {
    
    @IBAction private func settingsButtonTapped(_ sender: Any) {
        presenter.profileTapped()
    }
    
    // Перенести эту логику в пресентер
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        presenter.likedEvent()
    }
    
    // Перенести эту логику в пресентер
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        presenter.dislikedEvent()
        eventsContainerView.dislikeHandled()
    }
    
    @objc private func didReloadButtonTap() {
        reloadButton.alpha = 0.5
        presenter.reload()
    }
    
}

extension EventView {
    
    private func configureViews() {
        navigationController?.navigationBar.isHidden = false
        eventsContainerView.delegate = self
        
        view.addSubview(reloadButton)
        NSLayoutConstraint.activate([
            reloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            reloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            reloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            reloadButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
}


// MARK: - EventsContainerViewDelegate

extension EventView: EventsContainerViewDelegate {
    
    func allEventsShowed() {
        // были показаны все ивенты, следует убрать кнопки
        updateLikeButtonsAlpha(needHide: true)
    }
    
    private func updateLikeButtonsAlpha(
        needHide: Bool,
        withAnimation: Bool = true) {
        
        let alpha: CGFloat = needHide ? 0 : 1
        
        if withAnimation {
            UIView.animate(withDuration: 0.1, animations: {
                self.likeButton.alpha = alpha
                self.dislikeButton.alpha = alpha
            })
            
        } else {
            likeButton.alpha = alpha
            dislikeButton.alpha = alpha
        }
    }
    
}
