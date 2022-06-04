//
//  AutoDetectLanguageJSON.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

struct AutoDetectLanguageJSON: Decodable {
    
    var data: Detection
    
    init() {
        self.data = Detection()
    }
}

struct Detection: Decodable {
    
    var detections: [[DetectedLanguage]]
    
    init() {
        self.detections = [[DetectedLanguage()]]
    }
}

struct DetectedLanguage: Decodable {
    var confidence: Float
    var isReliable: Bool
    var language: String
    
    init() {
        self.confidence = 0
        self.isReliable = false
        self.language = ""
    }
}
