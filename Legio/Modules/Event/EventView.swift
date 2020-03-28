//
//  EventView.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventViewProtocol: class {
    func show(error: String)
    func showEvents(viewModels: [EventViewModel])
}

class EventView: UIViewController {
    
    @IBOutlet weak var eventsContainerView: EventsContainerView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet weak var partyButton: UIButton!
    @IBOutlet weak var nerdyButton: UIButton!
    @IBOutlet weak var likeDislikeButtons: UIStackView!
    @IBOutlet weak var partyNerdyButtons: UIStackView!
    @IBOutlet weak var bottomConstraintStackView: NSLayoutConstraint!
    
    var presenter: EventPresenterProtocol!
    var mainEvent = true
    
    private var isHiddenBottomButtons = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureNavigationBar(state: .hide)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension EventView: EventViewProtocol {
    
    func show(error: String) {
        plugsAlert(title: error)
    }
    
    func showEvents(viewModels: [EventViewModel]) {
        eventsContainerView.configure(viewModels: viewModels)
        likeButton.isEnabled = true
        dislikeButton.isEnabled = true
    }
}

//MARK: - Actions

extension EventView {
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        presenter.profileTapped()
    }
    
    // Перенести эту логику в пресентер
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        eventsContainerView.likeHandled()
//        if likeButton.isEnabled, dislikeButton.isEnabled {
//            dislikeButton.isEnabled = true
//            likeButton.isEnabled = false
//            isHiddenBottomButtons = true
//        } else {
//            if mainEvent {
//                if !isHiddenBottomButtons {
//                    bottomConstraintStackView.constant -= 100
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.view.layoutIfNeeded()
//                    }, completion: { finished in
//                        self.partyNerdyButtons.isHidden = true
//                    })
//                }
//            }
//            dislikeButton.isEnabled = true
//            likeButton.isEnabled = false
//            isHiddenBottomButtons = true
//        }
    }
    
    // Перенести эту логику в пресентер
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        eventsContainerView.dislikeHandled()
        //        if mainEvent {
//            if isHiddenBottomButtons {
//                partyNerdyButtons.isHidden = false
//                bottomConstraintStackView.constant += 100
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.view.layoutIfNeeded()
//                })
//                isHiddenBottomButtons = false
//            }
//        }
//        dislikeButton.isEnabled = false
//        likeButton.isEnabled = true
    }
    
    @IBAction func partyButtonTapped(_ sender: UIButton) {
        presenter.showParty()
    }
    
    @IBAction func nerdyButtonTapped(_ sender: UIButton) {
        presenter.showNerdy()
    }
    
}

extension EventView {
    
    private func configureViews() {
        navigationController?.navigationBar.isHidden = false
        partyNerdyButtons.isHidden = true
    }
    
}
