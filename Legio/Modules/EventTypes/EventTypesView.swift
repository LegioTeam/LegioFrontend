//
//  EventTypesView.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesViewProtocol: class {
    func updateData()
    func updateCell(row: Int)
}

class EventTypesView: UIViewController {
    
    private enum Constants {
        static let section: Int = 0
        static let cellIdentifier: String = "InterestCell"
    }
	
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: EventTypesPresenterProtocol!
    
	
	override func viewDidLoad() {
        
		super.viewDidLoad()
        configureUI()
        presenter.viewDidLoad()
	}
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        presenter.set(contentWidth: self.view.frame.width - 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.configureNavigationBar(state: .onlyBackButton)
    }
	
}

extension EventTypesView: EventTypesViewProtocol {
    
    internal func updateData() {
        collectionView.reloadData()
    }
    
    internal func updateCell(row: Int) {
        
        let indexPath: IndexPath = IndexPath(
            item: row,
            section: Constants.section)
    }
    
}

//MARK: - Actions
extension EventTypesView {
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        self.presenter.didNextTapped()
    }
    
}

extension EventTypesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? InterestCell {
            
            let viewModel = presenter.getCellViewModel(for: indexPath.row)
            cell.configure(viewModel: viewModel)
            return cell
            
        } else {
            let cell = UICollectionViewCell()
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.getCellSize(for: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: false)
        self.presenter.didSelectInterest(at: indexPath.row)
    }
    
}


extension EventTypesView {
    
    private func configureUI() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InterestCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
}
