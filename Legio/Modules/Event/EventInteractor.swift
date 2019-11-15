//
//  EventInteractor.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol EventInteractorProtocol {
    func loadEvent() -> Event?
}

class EventInteractor: EventInteractorProtocol {
    var event: Event?
    
    // данный код должен будет перейти в NetworkManager,  но в качестве модуля пойдет
    /*
    func loadEvent() -> Event? {
        var urlConstructor = URLComponents()
        let authValue: String? = "Bearer \(userData.token)"
        urlConstructor.scheme = "http"
        urlConstructor.host = "legio-app.tmweb.ru"
        urlConstructor.path = "/api/events"

        guard let registerURL = urlConstructor.url else {
            return nil
        }
        var request = URLRequest(url: registerURL)
        request.httpMethod = "POST"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let items = try JSONDecoder().decode(Event.self, from: data)
                    self.event?.id = items.id
                    self.event?.created = items.created
                    self.event?.updated = items.updated
                    self.event?.name = items.name
                    self.event?.category = items.category
                    self.event?.createdAt = items.createdAt
                    self.event?.starts = items.starts
                    self.event?.ends = items.ends
                    self.event?.image = items.image
                    self.event?.url = items.url
                    self.event?.location = items.location
                    self.event?.organization = items.organization
                    self.event?.tagName = items.tagName
                    self.event?.categoryName = items.categoryName
                } catch let error {
                    print(error)
                }
            }
        }.resume()
        return event
    }
    */
    
    //Временный код, для демонстрации экрана
    func loadEvent() -> Event? {
        let firstEvent = Event(id: 1103146, created: "2019-10-23", updated: "2019-10-23", name: "Мультимедийные выставки «Ван Гог. Письма к Тео» и «Густав Климт. Золото Модерна»", category: 1, createdAt: "2019-10-23", starts: "Сегодня, 21:00", ends: "Сегодня, 23:00", image: "eventImage", url: "https://artplay.timepad.ru/event/1072474/?r_p_t=event_top", location: "Нижняя Сыромятническая ул., д.10, строение 2", organization: "Центр цифрового искусства Artplay Media", tagName: "nerdy", categoryName: "art", coordinates: ["55.7527","37.6706"])
        let secondEvent = Event(id: 1086153, created: "2019-10-23", updated: "2019-10-23", name: "Практикум «Визуальный сторителлинг и драматургия для социальных медиапроектов»", category: 2, createdAt: "2019-10-23", starts: "Сегодня, 21:00", ends: "Сегодня, 23:00", image: "secondEvent", url: "https://blagosfera.timepad.ru/event/1086153/", location: "1-й Боткинский проезд, д. 7, строение 1", organization: "Благосфера", tagName: "nerdy", categoryName: "study", coordinates: ["55.7844","37.5584"])
        let thirdEvent = Event(id: 1090614, created: "2019-10-23", updated: "2019-10-23", name: "Бизнес-завтрак по ораторскому мастерству «Искусство импровизации»", category: 3, createdAt: "2019-10-23", starts: "Сегодня, 21:00", ends: "Сегодня, 23:00", image: "thirdEvent", url: "https://lidiya-spevak.timepad.ru/event/1090614/", location: "Кафе «Сценарио», Тверская 22В", organization: "ООО «Прогресс Терра»", tagName: "nerdy", categoryName: "business", coordinates: ["55.7673","37.6020"])
        let fourthEvent = Event(id: 553557, created: "2019-10-23", updated: "2019-10-23", name: "Московские Гуляки. Гоголевский и Никитский бульвары.", category: 4, createdAt: "2019-10-23", starts: "Сегодня, 20:00", ends: "Завтра, 22:00", image: "fourthEvent", url: "https://moskovskie-gulyaki.timepad.ru/event/553557/", location: "Станция метро Кропоткинская", organization: "Московские Гуляки", tagName: "party", categoryName: "walk", coordinates: ["+55.74478961122894", "+37.60189913226269"])
        let fifthEvent = Event(id: 5, created: "2019-10-23", updated: "2019-10-23", name: "Бесплатная экскурсия «Разноликая архитектура Большой Никитской и музыкальный Брюсов»", category: 5, createdAt: "2019-10-23", starts: "Завтра, 20:00", ends: "Сегодня, 22:00", image: "fifthEvent", url: "https://poulitcam.timepad.ru/event/950574/", location: "станция метро «Библиотека имени Ленина» к памятнику Ф. М. Достоевскому", organization: "По улицам и переулкам", tagName: "nerdy", categoryName: "walk", coordinates: ["55.7520","37.6108"])
        
        let events = [firstEvent,secondEvent,thirdEvent,fourthEvent,fifthEvent]
        let i = Int.random(in: 0 ... events.count-1)
        return events[i]
    }
}

