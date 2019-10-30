//
//  EventTypesView.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesViewProtocol {
	
}

class EventTypesView: UIViewController {
	
    @IBOutlet var collectionView: UICollectionView!
    //var router: EventTypesRouterProtocol?
    var presenter: EventTypesPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar(state: .onlyBackButton)
    }
	
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension EventTypesView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getEventTypes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventTypesCell", for: indexPath as IndexPath) as! EventTypesCell
        cell.layer.borderColor = UIColor(hex: "#F4F9FF")?.cgColor
        cell.layer.borderWidth = 2
        cell.configure(event:  presenter.getEventTypeByIndex(index: indexPath))
        return cell
    }
    
}

extension EventTypesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.getEventTypeByIndex(index: indexPath).value.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)
        ])
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
}

//MARK: - Actions
extension EventTypesView {
	
	@IBAction func buttonNextTapped(_ sender: Any) {
        presenter.showEventTypped()
	}
	
}
