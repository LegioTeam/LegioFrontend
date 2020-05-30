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
    var locationService: LocationService!
    
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
        view?.updateCell(row: row)
    }
    
}

extension EventTypesPresenter {
    
    private func getInterests() {
        
        let dispatchGroup = DispatchGroup()
        
        var interestError: Error? = nil
        var myInterests: [Int]? = nil
        var interestsResponse: InterestsResponse? = nil
        
        dispatchGroup.enter()
        interactor.getInterestList { response in
            switch response {
            case .success(let interests):
                interestsResponse = interests
                
            case .failure(let error):
                interestError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        interactor.getMyInterests { response in
            switch response {
            case .success(let interests):
                myInterests = interests
                
            case .failure(let error):
                interestError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            if let error = interestError {
                self?.view?.showError(title: "Ошибка", subtitle: error.localizedDescription)
                print(error.localizedDescription)
                
            } else if let interestsResponse = interestsResponse,
                let myInterests = myInterests {
                self?.handle(
                    interestsResponse: interestsResponse,
                    myInterests: myInterests)
                
            } else {
                let emptyDataError = NetworkError.emptyData
                self?.view?.showError(title: "Ошибка", subtitle: emptyDataError.localizedDescription)
                print(emptyDataError.localizedDescription)
                
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
            interactor.updateMyInterests(
            idInterests: idSelectedInterests) { [weak self] response in
                switch response {
                case .success:
                    self?.routeNextView()

                case .failure(let error):
                    self?.view?.showError(title: "Ошибка", subtitle: error.localizedDescription)
                }
            }
        } else {
            view?.showError(title: "Ошибка", subtitle: Texts.noSelectedInterests)
            print(Texts.noSelectedInterests)

        }
    }
    
    private func handle(interestsResponse: InterestsResponse, myInterests: [Int]) {
        interests = makeInterestsViewModel(
            interests: interestsResponse.interests, myInterests: myInterests)
        view?.updateData()
    }
    
    private func makeInterestsViewModel(interests: [Interest], myInterests: [Int]) -> [InterestCellViewModel] {
        
        return interests.compactMap({
            InterestCellViewModel(
                id: $0.id,
                name: $0.name,
                isSelected: myInterests.contains($0.id),
                containerWidth: contentWidth) })
    }
    
    private func routeNextView() {
        locationService.isEnabled()
            ? router.showEvents()
            : router.showGeoRequest()
    }

}

