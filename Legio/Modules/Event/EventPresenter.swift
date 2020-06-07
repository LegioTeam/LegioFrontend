//
//  EventPresenter.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventPresenterProtocol: class {
    
    /// Метод для получения событий
    func viewDidLoad()
    
    /// Метод обновления списка событий
    func reload()
    
    /// Метод, вызываемый когда пользователь нажал на Профиль
    func profileTapped()
    
    /// Пользователь лайкнул текущее событие
    func likedEvent()
    
    /// Пользовать дислайкнул текущее событие
    func dislikedEvent()
}

final class EventPresenter {
    
    private enum Texts {
        static let errorTitle: String = "Ошибка"
        static let errorMessage: String = "Что-то пошло не так"
        static let noEvents: String = "К сожалению, рядом с Вами не найдено событий"
        static let likedEventTitle: String = "Не пропустите это событие!"
        static let likedEventMessage: String = "Следующее будет доступно после окончания этого"
    }
    
    weak var view: EventViewProtocol?
    var interactor: EventInteractorProtocol!
    var router: EventRouterProtocol!
    var locationService: LocationService!
    
    private var events: [Event] = []
    var notification = NotificationDelegate()
    let locationManager = LocationManager.sharedManager
}

extension EventPresenter: EventPresenterProtocol {
    
    func viewDidLoad() {
        getEvents()
    }
    
    func reload() {
        getEvents()
    }
    
    func profileTapped() {
        router.showEventTypes()
    }
    
    func likedEvent() {
        
        guard let lastEvent = events.last else { return }
        
        interactor.like(event: lastEvent) { [weak self] result in
            switch result {
            case .success:
                self?.prepareEventMessage(for: lastEvent)
                
            case .failure(let error):
                self?.view?.showError(
                    title: Texts.errorTitle,
                    subtitle: error.localizedDescription)
            }
        }
    }
    
    func dislikedEvent() {
        guard let lastEvent = events.last else { return }
        interactor.dislike(event: lastEvent) { [weak self] result in
            switch result {
            case .success:
                self?.events.removeLast()
                
            case .failure(let error):
                self?.view?.showError(
                    title: Texts.errorTitle,
                    subtitle: error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Приватные методы
    
    private func showEvents() {
        let viewModels = makeEventViewModels()
        view?.showEvents(viewModels: viewModels)
    }
    
    private func openDetail(urlString: String) {
        router.showDetails(url: urlString)
    }
    
    private func makeEventViewModels() -> [EventViewModel] {
        
        var eventViewModels: [EventViewModel] = []
        
        if events.count > 0 {
            eventViewModels.append(EventViewModel(lastTitle: nil))
            
            eventViewModels.append(contentsOf: events.map({
                EventViewModel(
                    event: $0,
                    action: { [weak self] urlString in
                        self?.openDetail(urlString: urlString)
                })
            }))
            
        } else {
            eventViewModels.append(
                EventViewModel(lastTitle: Texts.noEvents))
        }
        
        return eventViewModels
    }
    
    /// Отображение пользователю уведомления о том, что он
    private func prepareEventMessage(for event: Event) {
        var title = Texts.likedEventTitle
        let message = Texts.likedEventMessage
        
        if let eventDate = DateStringConverter.date(from: event.startsAt) {
            let nowDate = Date()

            let difference = eventDate.timeIntervalSince(nowDate)

            let hours = Int(difference) / 3600
            let minutes = (Int(difference) / 60) % 60
            
            if hours > 0 || minutes > 0 {
                title = "Начало через "
                if hours > 0 {
                    title += "\(hours) час."
                }
                if minutes > 0 {
                    title += "\(minutes) мин."
                }
            }
        }
        
        view?.showLiked(title: title, subtitle: message)
    }
    
}

// MARK: - Сетевые методы
extension EventPresenter {
    
    private func getEvents() {
        
        let location = locationService.getCurrentLocation()
        
        interactor.getEvents(
            city: nil,
            location: location,
            distance: nil,
            metro: nil) { [weak self] result in
                
                switch result {
                case .success(let eventsResponse):
                    self?.events = eventsResponse.events
                    self?.showEvents()
                    
                case .failure(let error):
                    self?.view?.showError(
                        title: Texts.errorTitle,
                        subtitle: error.localizedDescription)
                }
        }
    }
    
}
