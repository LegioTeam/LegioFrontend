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
}

class EventView: UIViewController {
    
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var heightEventName: NSLayoutConstraint!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var eventPlaceLabel: UILabel!
    @IBOutlet var detailsButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet weak var partyButton: UIButton!
    @IBOutlet weak var nerdyButton: UIButton!
    @IBOutlet weak var likeDislikeButtons: UIStackView!
    @IBOutlet weak var partyNerdyButtons: UIStackView!
    @IBOutlet weak var bottomConstraintStackView: NSLayoutConstraint!
    
    var presenter: EventPresenterProtocol!
    
    private var isHiddenBottomButtons = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Actions

extension EventView: EventViewProtocol {
    
    func show(error: String) {
        plugsAlert(title: error)
    }
    
    @IBAction func profileButton(_ sender: UIButton) {
        presenter.profileTapped()
    }
    
    @IBAction func detailsButton(_ sender: UIButton) {
        presenter.detailsTapped()
    }
    
    // Перенести эту логику в пресентер
    @IBAction func likeButton(_ sender: UIButton) {
        if likeButton.isEnabled, dislikeButton.isEnabled {
            dislikeButton.isEnabled = true
            likeButton.isEnabled = false
            isHiddenBottomButtons = true
        } else {
            if !isHiddenBottomButtons {
                bottomConstraintStackView.constant -= 100
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    self.partyNerdyButtons.isHidden = true
                })
                dislikeButton.isEnabled = true
                likeButton.isEnabled = false
                isHiddenBottomButtons = true
            }
        }
        
    }
    
    // Перенести эту логику в пресентер
    @IBAction func dislikeButton(_ sender: UIButton) {
        if isHiddenBottomButtons {
            partyNerdyButtons.isHidden = false
            bottomConstraintStackView.constant += 100
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            dislikeButton.isEnabled = false
            likeButton.isEnabled = true
            isHiddenBottomButtons = false
        }
    }
}

extension EventView {
    
    private func configureViews() {
        self.navigationController?.navigationBar.isHidden = true
        partyNerdyButtons.isHidden = true
        eventImage.image = presenter.loadImage()
        eventNameLabel.attributedText = presenter.configureNameLabel()
        eventDateLabel.attributedText = presenter.configureDateLabel()
        eventPlaceLabel.text = presenter.correctAddress()
    }
    
}

