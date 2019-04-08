//
//  ExtensionTest.swift
//  KcalEatenTests
//
//  Created by Gregory De knyf on 08/04/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import XCTest
@testable import KcalEaten

class ExtensionTest: XCTestCase {

    //------------------------
    //MARK: - Date
    //------------------------

    func testTransformDateFormatToStringFormat() {
        let expectedStringDate = "12 avril 2014"

        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 12
        components.month = 4
        components.year = 2014
        components.timeZone = TimeZone(abbreviation: "GMT+0:00")

        let date = calendar.date(from: components)

        XCTAssertEqual(date?.toString(), expectedStringDate)
    }

}
