//
//  FakeResponseData.swift
//  KcalEatenTests
//
//  Created by Gregory De knyf on 13/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

class FakeResponData {

    //------------------------
    //MARK: - Data
    //------------------------

    //OpenFoodFact data
    static var openFoodFact: Data? {
        let bundle = Bundle(for: FakeResponData.self)
        let url = bundle.url(forResource: "OpenFoodFact", withExtension: "json")!
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
