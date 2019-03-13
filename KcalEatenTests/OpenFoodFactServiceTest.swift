//
//  OpenFoodFactServiceTest.swift
//  KcalEatenTests
//
//  Created by Gregory De knyf on 13/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import XCTest
@testable import KcalEaten

class OpenFoodFactServiceTest: XCTestCase {

    // MARK: - Service
    func testGetCurrencyShouldPostFailedCallback() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "") { (success, product, error) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "") { (success, product, error) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: FakeResponseData.openFoodFact, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "") { (success, product, error) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }


        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "") { (success, product, error) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }


        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: FakeResponseData.openFoodFact, response: FakeResponseData.responseOK, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "3029330003533") { (success, product, error) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(product)
            XCTAssertNotNil(product!.barCode)
            XCTAssertNotNil(product!.name)
            XCTAssertNil(error)

            XCTAssertEqual(product!.barCode!, "3029330003533")
            XCTAssertEqual(product!.name!, "Crousti Moelleux Complet")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
