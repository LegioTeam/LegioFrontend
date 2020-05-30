//
//  EventPresenter.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventPresenterProtocol: class {
    func viewDidLoad()
    
    func profileTapped()
    
    func configureTextLabel(string: String) -> NSAttributedString
    func configureNameLabel() -> NSAttributedString
    func configureDateLabel() -> NSAttributedString
    func correctAddress() -> String
    func loadImage() -> UIImage?
    func showParty()
    func showNerdy()
    func fetchLocationInfo(completion: @escaping (String?) -> Void)
}

class EventPresenter {
    
    private enum Texts {
        static let errorTitle: String = "Ошибка"
        static let errorMessage: String = "Что-то пошло не так"
        static let defaultEventStart = "Сегодня, 20:45"
    }
    
    weak var view: EventViewProtocol?
    var interactor: EventInteractorProtocol!
    var router: EventRouterProtocol!
    var locationService: LocationService!
    var event: Event?
    
    private var events: [Event] = []
    let defaultEventImage: String = "eventImage"
    var notification = NotificationDelegate()
    let locationManager = LocationManager.sharedManager
    var expectedTravelTime: String?
}

extension EventPresenter: EventPresenterProtocol {
    
    func viewDidLoad() {
        getEvents()
    }
    
    func profileTapped() {
        router.showProfile()
    }

    func fetchLocationInfo(completion: @escaping (String?) -> Void) {
        //        locationManager.getWalkingDistance(destination: self.event!.coordinates) {
        //            distanceString, metres in
        //            self.expectedTravelTime = distanceString
        //            completion(self.expectedTravelTime)
        //        }
    }
    
    func showParty() {
        router.showParty()
    }
    
    func showNerdy() {
        router.showNerdy()
    }
    
    private func showEvents() {
        let eventsViewModel = events.map({
            EventViewModel(
                event: $0,
                action: { [weak self] urlString in
                    self?.openDetail(urlString: urlString)
            })
        })
        view?.showEvents(viewModels: eventsViewModel)
    }
    
    private func openDetail(urlString: String) {
        router.showDetails(url: urlString)
    }
    
}

// Показывает информацию по заказу
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
                    if eventsResponse.events.count > 0 {
                        self?.event = eventsResponse.events[0]
                    }
                    self?.showEvents()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func loadImage() -> UIImage? {
        
        guard let event = event,
            let imageUrl = event.posterImage?.original,
            let url = URL(string: imageUrl) else {
                return defaultImage()
        }
        
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data) ?? defaultImage()
            
        } catch {
            return defaultImage()
        }
    }
    
    func defaultImage() -> UIImage? {
        return UIImage(named: defaultEventImage)
    }
    
    func configureTextLabel(string: String) -> NSAttributedString {
        let textBgColor: UIColor = UIColor.legio.legioBlue
        let attributes = [NSAttributedString.Key.backgroundColor: textBgColor]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        return attributedString
    }
    
    func configureNameLabel() -> NSAttributedString {
        return configureTextLabel(string: event?.name ?? "Мультимедийные выставки «Ван Гог. Письма к Тео» и «Густав Климт. Золото Модерна»")
    }
    
    func configureDateLabel() -> NSAttributedString {
        
        let returnedText = event?.startsAt ?? Texts.defaultEventStart
        return configureTextLabel(string: returnedText)
    }
    
    func correctAddress() -> String {
        //        let dictionary: [String: String] = [
        //            "площадь": "пл.",
        //            "район": "р-н",
        //            "бульвар": "б-р",
        //            "линия": "линия",
        //            "шоссе": "ш.",
        //            "улица": "ул.",
        //            "дом": "д.",
        //            "проспект": "пр-т",
        //            "корпус": "корп.",
        //            "проезд": "пр.",
        //            "строение": "стр.",
        //            "переулок": "пер.",
        //            "этаж": "этаж",
        //            "набережная": "наб.",
        //            "квартира":"кв."
        //            ]
        //        guard var correctAddress = event?.location else { return "Басманный пер, 5" }
        //
        //        for (key, value) in dictionary {
        //            correctAddress = correctAddress.replacingOccurrences(of: key, with: value)
        //        }
        //        return correctAddress
        return ""
        //        for (key, value) in dictionary {
        //            correctAddress = correctAddress.replacingOccurrences(of: key, with: value)
        //        }
        //        return correctAddress
    }
}
