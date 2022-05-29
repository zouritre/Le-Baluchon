//
//  ConvertCurrencyTest.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 29/05/2022.
//

import Foundation

import XCTest
@testable import Le_Baluchon

class ConvertCurrencyTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //If error  received
    func testConvertCurrencyShouldPostFailedCallbackIfError() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: nil, response: nil, error: FakeResponse.error)

    // When
        CurrencyService.shared.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }
    
    //If no data received
    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: nil, response: nil, error: nil)

    // When
        CurrencyService.shared.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }
    
    //If connexion failed
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: FakeResponse.correctCurrencySymbolData, response: FakeResponse.responseKO, error: nil)

    // When
        CurrencyService.shared.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }
    
    //If data decoding failed
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: FakeResponse.incorrectCurrencyData, response: FakeResponse.responseOK, error: nil)

    // When
        CurrencyService.shared.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }
    
    //If correct data and no error
    func testGetCurrencyShouldPostFailedCallbackIfCorrectDataAndNoError() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: FakeResponse.correctCurrencyConversionData, response: FakeResponse.responseOK, error: nil)

    // When
        CurrencyService.shared.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            
            guard let result = result else {
                XCTAssertNotNil(result)
                return
            }
            
            //Check if datas matches
            XCTAssertEqual(result, 4012.739875)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
