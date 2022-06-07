//
//  WeatherServiceTest.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 06/06/2022.
//

import XCTest
@testable import Le_Baluchon

class WeatherServiceTest: XCTestCase {

    var urlSession: URLSession?
    
    var weatherService = WeatherService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: configuration)
        
        NetworkService.shared.session = urlSession!
    
    }
    
    //If correct data and no error
    func testGetCoordinatesShouldPostSuccessCallBackIfCorrectDataAndNoError() {
    // Given
        // Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctGetCoordinatesData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getCoordinates(zip: 69003, countryCode: "fr") { geoData, error in
            
    // Then
            XCTAssertEqual(geoData!["lat"], 45.7485)
            XCTAssertEqual(geoData!["lon"], 4.8467)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }

    //If data decoding failed
    func testGetCoordinatesShouldPostFailedCallbackIfIncorrectData() {
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

        weatherService.getCoordinates(zip: 69003, countryCode: "fr") { geoData, error in
            
    // Then
            XCTAssertNil(geoData)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If correct data and no error
    func testWeatherShouldPostSuccessCallBackIfCorrectDataAndNoError() {
    // Given
        // Set mock data
        let response = FakeResponse.responseOK
        let data = FakeResponse.correctGetWeatherData!
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }

    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(lat: 35, lon: 139) { weatherData, error in
            
    // Then
            XCTAssertEqual(weatherData!["temperature"] as? Float, 14.62)
            XCTAssertEqual(weatherData!["description"] as? String, "nuageux")
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }
    
    //If data decoding failed
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
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

        weatherService.getWeather(lat: 35, lon: 139) { weatherData, error in
            
    // Then
            XCTAssertNil(weatherData)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
    }

}
