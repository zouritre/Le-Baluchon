//
//  CurrencyServiceTest.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import XCTest
@testable import Le_Baluchon

class CurrencyServiceTest: XCTestCase {

    var urlSession: URLSession?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: configuration)

        NetworkService.shared.session = urlSession!
    }
    
    //Convert currency data decoding failed
    func testConvertCurrencyShouldPostFailedCallbackIfIncorrectData() {
    // Given
        //Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.incorrectData!
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        CurrencyService.convertCurrencies(from: "", to: "", amount: ""){ result, error in

    // Then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //Convert currency correct data and no error
    func testConvertCurrencyShouldPostSuccessCallbackIfCorrectDataAndNoError() {
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
        CurrencyService.convertCurrencies(from: "", to: "", amount: ""){ result, error in

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
    
    //Get currency symbol decoding failed
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
    // Given
        // Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.incorrectData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        CurrencyService.getCurrencies{ currency, error in

    // Then
            XCTAssertNil(currency)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //Get currency symbol correct data and no error
    func testGetCurrencyShouldPostSuccessCallbackIfCorrectDataAndNoError() {
    // Given
        // Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctCurrencySymbolData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        CurrencyService.getCurrencies{ currencies, error in

    // Then
            XCTAssertNotNil(currencies)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
}
