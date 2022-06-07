//
//  SupportedLanguagesCodeResponse.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 02/06/2022.
//

import Foundation

struct SupportedLanguagesJSON: Decodable {
    
    var data: Languages = Languages()
    
}

struct Languages: Decodable {
    
    var languages: [Language] = [Language()]
    
}

struct Language: Decodable {
    
    var language: String = ""
    var name: String = ""
    
}
