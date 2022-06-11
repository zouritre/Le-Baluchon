//
//  AutoDetectLanguageJSON.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

struct AutoDetectLanguageJSON: Decodable {
    
    var data: Detection = Detection()
}

struct Detection: Decodable {
    
    var detections: [[DetectedLanguage]] = [[DetectedLanguage()]]
    
}

struct DetectedLanguage: Decodable {
    var confidence: Float = 0
    var isReliable: Bool = false
    var language: String = ""
    
}
