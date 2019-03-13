//
//  FakeResponseData.swift
//  KcalEatenTests
//
//  Created by Gregory De knyf on 13/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

class FakeResponseData {

    //------------------------
    //MARK: - Data
    //------------------------

    //OpenFoodFact data
    static var openFoodFactBarCodeOK: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "OpenFoodFactBarCodeOK", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let incorrectData = "erreur".data(using: .utf8)!

    //------------------------
    //MARK: - Response
    //------------------------

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    //------------------------
    //MARK: - Error
    //------------------------
    
    class QuoteError: Error {}
    static let error = QuoteError()
}
