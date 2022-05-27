//
//  Le_BaluchonTests.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 22/05/2022.
//

import XCTest
@testable import Le_Baluchon

class CurrencyServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //If error  received
    func testGetCurrencyShouldPostFailedCallbackIfError() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: nil, response: nil, error: FakeCurrencySymbolResponse.error)

    // When
        CurrencyService.shared.getCurrencies{ currency, error in

    // Then
            XCTAssertNil(currency)
            XCTAssertNotNil(error)
        }
    }
    
    //If no data received
    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: nil, response: nil, error: nil)

    // When
        CurrencyService.shared.getCurrencies{ currency, error in

    // Then
            XCTAssertNil(currency)
            XCTAssertNotNil(error)
        }
    }
    
    //If connexion failed
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: FakeCurrencySymbolResponse.correctCurrencySymbolData, response: FakeCurrencySymbolResponse.responseKO, error: nil)

    // When
        CurrencyService.shared.getCurrencies{ currency, error in

    // Then
            XCTAssertNil(currency)
            XCTAssertNotNil(error)
        }
    }
    
    //If data decoding failed
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: FakeCurrencySymbolResponse.incorrectCurrencyData, response: FakeCurrencySymbolResponse.responseOK, error: nil)

    // When
        CurrencyService.shared.getCurrencies{ currency, error in

    // Then
            XCTAssertNil(currency)
            XCTAssertNotNil(error)
        }
    }
    
    //If correct data and no error
    func testGetCurrencyShouldPostFailedCallbackIfCorrectDataAndNoError() {
    // Given
        CurrencyService.shared.session = URLSessionFake(data: FakeCurrencySymbolResponse.correctCurrencySymbolData, response: FakeCurrencySymbolResponse.responseOK, error: nil)

    // When
        CurrencyService.shared.getCurrencies{ currencies, error in

    // Then
            XCTAssertNotNil(currencies)
            XCTAssertNil(error)
            
            guard let currencies = currencies else {
                
                //Fail the test if currencies become nil for some reason
                XCTAssertNotNil(currencies)
                
                return
            }
            
            //Check if datas matches
            for (key, value) in currencies {
                
                if key == "AED" {
                    XCTAssertEqual(value, "United Arab Emirates Dirham")
                }
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
