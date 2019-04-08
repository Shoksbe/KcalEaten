//
//  Extensions.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 20/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

extension Date {
    ///Transform a date into a String, keeping only the date and not the time.
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = DATE_FORMAT
        dateFormatter.locale = LOCAL
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        return dateFormatter.string(from: self)
    }

    ///Give the date of the day without the time.
    func today() -> Date {
        let dateString = Date().toString()

        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
        formatter.locale = LOCAL
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")

        return formatter.date(from: dateString) ?? Date()
    }
}

extension Notification.Name {
    static let favoriteStateOfProductDidChange = Notification.Name("favoriteStateOfProductDidChange")
    static let popupWillDisappear = Notification.Name("popupWillDisappear")
}
