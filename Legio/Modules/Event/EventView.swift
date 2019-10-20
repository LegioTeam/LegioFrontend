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
    private var event: Event?
    
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
    
    //тут аналогично, если в пресентер перенести "event", то вью не будет знать о том, что открывается, оно просто передает в презентер, что нажата определенная кнопка
    @IBAction func detailsButton(_ sender: UIButton) {
        presenter.detailsTapped(url: event?.url ?? "https://www.yandex.ru")
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
        
        // Тут ты пытаешся грузить данные с сервака, если заглушка, то ок, если нет - то загрузку изображения надо убирать в интерактор, и логику отображения данных убирать в презентер
        eventImage.downloaded(from:event?.image ?? "https://image.freepik.com/free-vector/error-404-found-glitch-effect_8024-4.jpg")
        
        //аналогично, тут остается функция принимающая значение, а ?? и по сути, сам "event" уйдут в пресентер
        eventNameLabel.attributedText = presenter.configureTextLabel(string: event?.name ?? "Данные не загружены с сервера")
        eventDateLabel.attributedText = presenter.configureTextLabel(string: event?.starts ?? "Нет данных")
        eventPlaceLabel.text = presenter.correctAddress(address: event?.location ?? "Нет данных")
    }
    
}

