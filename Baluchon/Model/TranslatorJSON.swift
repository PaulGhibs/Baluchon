//
//  TranslatorJSON.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 02/08/2021.
//  swiftlint:disable all


import Foundation

/* Managing data coming from google api as codable google response is
 "data": {
 "translations": [
 {
 "translatedText": "Bonjour Monde!"
 }
 ]
 }
 */

struct TranslatorJson: Codable {
    let data: Translations
    // nested struct for Translations Data
    struct Translations: Codable {
        var translations: [TranslatedText]
        // nested struct for TranslatedText as codable with a string var for translatedText
        struct TranslatedText: Codable {
            var translatedText: String
        }
    }
    // dependencies injection for testing
    init(data: Translations) {
        self.data = data
    }
}
