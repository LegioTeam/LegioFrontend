//
//  DateTimeConverter.swift
//  Legio
//
//  Created by Mac on 26.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

class DateStringConverter {
    
    enum DateFormat: String {
        case input = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case output = "dd.MM.yyyy HH:mm"
    }
    
    private enum Constants {
        static let defaultDate: String = ""
    }
    
    static func convert(input: String) -> String {
        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = DateFormat.input.rawValue
        if let date = formatter.date(from: input) {
            formatter.dateFormat = DateFormat.output.rawValue
            return formatter.string(from: date)
            
        } else {
            return Constants.defaultDate
        }
    }
    
    static func date(from input: String, format: DateFormat = .input) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: input)
    }
}
