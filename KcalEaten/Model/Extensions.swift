//
//  Extensions.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 20/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = LOCAL
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = LOCAL
        return formatter.date(from: self) ?? Date()
    }
}
