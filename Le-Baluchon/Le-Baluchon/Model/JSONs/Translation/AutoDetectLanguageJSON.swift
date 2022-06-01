//
//  AutoDetectLanguageJSON.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

struct AutoDetectLanguageJSON: Decodable {
    
    var data: DataDetection
    
    init() {
        self.data = DataDetection()
    }
}

struct DataDetection: Decodable {
    
    var detections: [[Detection]]
    
    init() {
        self.detections = [[Detection()]]
    }
}

struct Detection: Decodable {
    var confidence: Int
    var isReliable: Bool
    var language: String
    
    init() {
        self.confidence = 0
        self.isReliable = false
        self.language = ""
    }
}
