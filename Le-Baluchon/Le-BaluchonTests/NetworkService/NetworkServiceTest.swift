//
//  NetworkServiceTest.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import XCTest
@testable import Le_Baluchon

class NetworkServiceTest: XCTestCase {

    var urlSession: URLSession?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: configuration)
        
        NetworkService.shared.session = urlSession!
    
    }

    //If error  received
    func testMakeRequestShouldPostFailedCallbackIfError() {
    // Given
        //Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctCurrencySymbolData!
        let error = FakeResponse.error

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        NetworkService.shared.makeRequest(request: URLRequest(url: URL(string: "any")!), dataStructure: CurrencySymbolJson()){ data, error in

    // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If no data received
    func testMakeRequestShouldPostFailedCallbackIfNoResponse() {
    // Given
        //Set mock data
        let response: HTTPURLResponse? = nil
        let data: Data? = nil
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        NetworkService.shared.makeRequest(request: URLRequest(url: URL(string: "any")!), dataStructure: CurrencySymbolJson()){ data, error in

    // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If connexion failed
    func testMakeRequestShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
        // Set mock data
        let response = FakeResponse.responseKO
        let data = FakeResponse.correctCurrencySymbolData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        NetworkService.shared.makeRequest(request: URLRequest(url: URL(string: "any")!), dataStructure: CurrencySymbolJson()){ data, error in

    // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If data decoding failed
    func testMakeRequestShouldPostFailedCallbackIfIncorrectData() {
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

        NetworkService.shared.makeRequest(request: URLRequest(url: URL(string: "any")!), dataStructure: CurrencySymbolJson()){ data, error in

    // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If correct data and no error
    func testMakeRequestShouldPostSuccessCallbackIfCorrectDataAndNoError() {
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

        NetworkService.shared.makeRequest(request: URLRequest(url: URL(string: "any")!), dataStructure: CurrencySymbolJson()){ data, error in

    // Then
            XCTAssertNotNil(data)
            XCTAssertNil(error)
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
