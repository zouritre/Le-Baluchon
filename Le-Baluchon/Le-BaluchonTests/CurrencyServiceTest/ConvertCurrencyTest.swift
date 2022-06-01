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

    var urlSession: URLSession?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: configuration)

        NetworkService.shared.session = urlSession!
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //If error  received
    func testConvertCurrencyShouldPostFailedCallbackIfError() {
    // Given
        //Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctCurrencyConversionData!
        let error: Error? = FakeResponse.error

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        CurrencyService.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If no data received
    func testConvertCurrencyShouldPostFailedCallbackIfNoData() {
    //Given
        //Set mock data
        let response: HTTPURLResponse? = nil
        let data: Data? = nil
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        CurrencyService.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If connexion failed
    func testConvertCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
        //Set mock data
        let response = FakeResponse.responseKO
        let data = FakeResponse.correctCurrencyConversionData!
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        CurrencyService.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If data decoding failed
    func testConvertCurrencyShouldPostFailedCallbackIfIncorrectData() {
    // Given
        //Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.incorrectCurrencyData!
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        CurrencyService.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If correct data and no error
    func testConvertCurrencyShouldPostFailedCallbackIfCorrectDataAndNoError() {
    // Given
        //Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctCurrencyConversionData!
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

    // When
        CurrencyService.convertCurrencies(from: "GBP", to: "JPY", amount: "25"){ result, error in

    // Then
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            
            //Check if datas matches
            XCTAssertEqual(result!, 4012.739875)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
