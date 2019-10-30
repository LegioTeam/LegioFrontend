//
//  FeedbackView.swift
//  Legio
//
//  Created by Mikhail Semerikov on 29.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol FeedbackViewProtocol: class {
    func show(error: String)
}

class FeedbackView: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    var presenter: FeedbackPresenterProtocol!
    var nameEvent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameLabel.text = nameEvent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureNavigationBar(state: .hide)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Actions

extension FeedbackView: FeedbackViewProtocol {
    
    func show(error: String) {
        plugsAlert(title: error)
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        presenter.tapButton(button: "Close")
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        presenter.tapButton(button: "Like")
    }
    
    @IBAction func dislikeButton(_ sender: UIButton) {
        presenter.tapButton(button: "Dislike")
    }
    
}
