//
//  EventTypesInteractor.swift
//  Legio
//
//  Created by Sergey Mikhailov on 30.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol EventTypesInteractorProtocol {
    func getData() ->[EventTypesEntity<String>]
    func setData(eventTypes: [EventTypesEntity<String>])
}

class EventTypesInteractor : EventTypesInteractorProtocol{
    func getData() ->[EventTypesEntity<String>]{
        //стандартные данные для примера

        let buisnes = EventTypesEntity<String>(value: "Бизнес")
        let science = EventTypesEntity<String>(value: "Наука")
        //### Кино
        let movie = EventTypesEntity<String>(value: "Кино")
        let nezavisimoe = EventTypesEntity<String>(value: "Независимое")
        let komercheskoe = EventTypesEntity<String>(value: "Коммерческое")
        let evropeiskoe = EventTypesEntity<String>(value: "Европейское")
        movie.addChild(nezavisimoe)
        movie.addChild(komercheskoe)
        movie.addChild(evropeiskoe)
        //### Спорт
        let sport = EventTypesEntity<String>(value: "Спорт")
        let kiber = EventTypesEntity<String>(value: "Кибер")
        let komandniy = EventTypesEntity<String>(value: "Командный")
        let individyalniy = EventTypesEntity<String>(value: "Индивидуальный")
        let ekstremalniy = EventTypesEntity<String>(value: "Экстремальный")
        sport.addChild(kiber)
        sport.addChild(komandniy)
        sport.addChild(individyalniy)
        sport.addChild(ekstremalniy)
        //### Иностранные языки
        let languages = EventTypesEntity<String>(value: "Иностранные языки")
        let english = EventTypesEntity<String>(value: "Английский")
        let chenise = EventTypesEntity<String>(value: "Китайский")
        let detch = EventTypesEntity<String>(value: "Немецкий")
        languages.addChild(english)
        languages.addChild(chenise)
        languages.addChild(detch)
        //### ИТ и интернет
        let itWeb = EventTypesEntity<String>(value: "ИТ и интернет")
        return [buisnes, science, movie, sport, languages, itWeb]
    }
    
    func setData(eventTypes: [EventTypesEntity<String>]) {
        //куда-то сохраняем
    }
    

}
