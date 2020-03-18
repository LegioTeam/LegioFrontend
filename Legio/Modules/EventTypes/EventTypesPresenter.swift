//
//  EventTypesPresenter.swift
//  Legio
//
//  Created by Mac on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesPresenterProtocol {
    var itemsCount: Int { get }
    func viewDidLoad()
    func set(contentWidth: CGFloat)
    func getCellSize(for row: Int) -> CGSize
    func getCellViewModel(for row: Int) -> InterestCellViewModel
    func didSelectInterest(at row: Int)
    func didNextTapped()
}

class EventTypesPresenter {
    
    private enum Texts {
        static let noSelectedInterests: String = "Вы не выбрали интересы"
    }
    
    weak var view: EventTypesViewProtocol?
    var router: EventTypesRouterProtocol!
    var interactor: EventTypesInteractorProtocol!
    
    private var contentWidth: CGFloat = 0
    private var interests: [InterestCellViewModel] = []
    
    private var interestCell: InterestDefaultCell? = nil
   
}

extension EventTypesPresenter: EventTypesPresenterProtocol {

    internal var itemsCount: Int {
        return interests.count
    }
    
    internal func didNextTapped() {
        saveInterests()
    }
    
    internal func viewDidLoad() {
        getInterests()
    }
    
    internal func set(contentWidth: CGFloat) {
        self.contentWidth = contentWidth
    }
    
    internal func getCellSize(for row: Int) -> CGSize {
        return interests[row].cellSize
    }
    
    internal func getCellViewModel(for row: Int) -> InterestCellViewModel {
        return interests[row]
    }
    
    internal func didSelectInterest(at row: Int) {
        interests[row].isSelected = !interests[row].isSelected
        self.view?.updateData()
    }
    
}

extension EventTypesPresenter {
    
    private func getInterests() {
        
        self.interactor.getInterestList { [weak self] result in
            
            switch result {
            case .success(let interestsList):
                self?.handle(interestsList)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveInterests() {
        
        let idSelectedInterests: [Int] = interests.compactMap({
            $0.isSelected
                ? $0.id
                : nil
        })
        
        if idSelectedInterests.count > 0 {
            interactor.updateMyInterests(idInterests: idSelectedInterests)
        } else {
            //TO DO: Сделать универсальный вывод алертов
            //showError()
            print(Texts.noSelectedInterests)
            
        }
    }
    
    private func handle(_ interestsList: InterestsList) {
        interests = makeInterestsViewModel(
            interests: interestsList.interests)
        view?.updateData()
    }
    
    private func makeInterestsViewModel(interests: [Interest]) -> [InterestCellViewModel] {
        
        return interests.compactMap({ InterestCellViewModel(id: $0.id, name: $0.name, containerWidth: contentWidth) })
    }

}

