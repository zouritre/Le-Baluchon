//
//  TranslationServiceTest.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import XCTest
@testable import Le_Baluchon

class TranslationServiceTest: XCTestCase {

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
    
    //If data decoding failed
    func testTranslateTextShouldPostFailedCallbackIfIncorrectData() {
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

        TranslationService.translateText(q: "", source: "", target: "") { translation, error in

    // Then
            XCTAssertNil(translation)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If correct data and no error
    func testTranslateTextShouldPostSuccessCallBackIfCorrectDataAndNoError() {
    // Given
        // Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctTranslationData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        TranslationService.translateText(q: "", source: "", target: "") { translation, error in

    // Then
            XCTAssertNotNil(translation)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If data decoding failed
    func testDetectLanguageShouldPostFailedCallbackIfIncorrectData() {
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

        TranslationService.detectLanguage(q: "") { translation, error in

    // Then
            XCTAssertNil(translation)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If correct data and no error
    func testDetectLanguageShouldPostSuccessCallBackIfCorrectDataAndNoError() {
    // Given
        // Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctAutoDetectLanguageData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        TranslationService.detectLanguage(q: "") { languageCode, error in

    // Then
            XCTAssertNotNil(languageCode)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }

}

