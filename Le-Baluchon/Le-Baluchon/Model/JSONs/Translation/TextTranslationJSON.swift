//
//  TextTranslationJSON.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 01/06/2022.
//

import Foundation

struct TextTranslationJSON: Decodable {
    
    var data: TextTranslation
    
    init() {
        self.data = TextTranslation()
    }
}

struct TextTranslation: Decodable {
    
    var translations: [Translatedtext]
    
    init() {
        self.translations = [Translatedtext()]
    }
}

struct Translatedtext: Decodable {
    
    var translatedText: String
    
    init() {
        self.translatedText = ""
    }
}
