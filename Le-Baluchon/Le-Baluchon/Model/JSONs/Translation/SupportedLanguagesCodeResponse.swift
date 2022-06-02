//
//  SupportedLanguagesCodeResponse.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 02/06/2022.
//

import Foundation

struct SupportedLanguagesCodeResponse: Decodable {
    
    var data: Languages
    
    init() {
        self.data = Languages()
    }
}

struct Languages: Decodable {
    
    var languages: [Language]
    
    init() {
        self.languages = [Language()]
    }
}

struct Language: Decodable {
    
    var language: String
    var name: String
    
    init() {
        self.language = ""
        self.name = ""
    }
}
