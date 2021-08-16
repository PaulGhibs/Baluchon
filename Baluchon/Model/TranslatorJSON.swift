//
//  TranslatorJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 02/08/2021.
//

import Foundation

// Managing data coming from google api
struct TranslatorJson: Codable {
    let data: Translations

    struct Translations: Codable {
        var translations: [TranslatedText]

        struct TranslatedText: Codable {
            var translatedText: String
        }
    }
}

