//
//  EventViewModel.swift
//  Legio
//
//  Created by Mac on 26.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

struct EventViewModel {
    
    private enum DefaultConstants {
        static let imageName: String = "eventImage"
        static let urlString: String = ""
    }
    
    private enum Texts {
        static let title = "На сегодня событий больше нет(("
    }
    
    /// Свойство, показывающее, что модель последняя в коллекции
    let isLast: Bool
    let name: String
    let date: String
    let place: String
    
    let imageUrl: URL?
    let defaultImage: UIImage?
    let detailUrlString: String
    let action: ((String) -> Void)?
    
    init(event: Event, action: ((String) -> Void)?) {
        self.isLast = false
        self.name = event.name
        self.place = "\(event.location.country), \(event.location.city), \(event.location.address)"
        self.date = DateStringConverter.convert(input: event.startsAt)
        self.imageUrl = URL(string: event.posterImage?.original ?? DefaultConstants.urlString)
        self.defaultImage = UIImage(named: DefaultConstants.imageName)
        self.detailUrlString = event.url ?? "https://www.pikabu.ru"
        self.action = action
    }
    
    /// Инициализация последнего элемента
    init(lastTitle: String?) {
        self.isLast = true
        if let title = lastTitle {
            self.name = title
        } else {
            self.name = Texts.title
        }
        self.date = ""
        self.place = ""
        self.detailUrlString = ""
        
        self.action = nil
        self.imageUrl = nil
        self.defaultImage = nil
    }
}
