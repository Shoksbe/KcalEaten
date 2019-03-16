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
    func testGetProductShouldPostFailedCallback() {
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
            XCTAssertEqual(error!, ApiError.noData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductShouldPostFailedCallbackIfNoData() {
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
            XCTAssertEqual(error!, ApiError.noData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: FakeResponseData.openFoodFactBarCodeOK, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "") { (success, product, error) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            XCTAssertEqual(error!, ApiError.noData)
            expectation.fulfill()
        }


        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductShouldPostFailedCallbackIfIncorrectData() {
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
            XCTAssertEqual(error!, ApiError.failedToDecode)
            expectation.fulfill()
        }


        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductShouldPostFailedCallbackIfNoErrorAndCorrectDataButIncorrectBarCode() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: FakeResponseData.openFoodFactBarCodeKO, response: FakeResponseData.responseOK, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        openFoodFactService.getProduct(from: "302933000533") { (success, product, error) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            XCTAssertEqual(error!, ApiError.noProductFound)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetProductShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let openFoodFactService = OpenFoodFactService(
            session: URLSessionFake(data: FakeResponseData.openFoodFactBarCodeOK, response: FakeResponseData.responseOK, error: nil))

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

        wait(for: [expectation], timeout: 0.1)
    }


}
