//
//  Translator.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation

// Translator API
struct TranslatorService {
    // MARK: - Properties
    
    static func getTranslation(for text: String) -> URLRequest {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = Translate.url + encodedText!
        let url = URL(string: completeURL)!
        var request = URLRequest(url: url)
        request.httpMethod = MethodHttp.post.rawValue
        return request
    }
    
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        guard let json = try? decoder.decode(TranslatorJson.self, from: data) else {
            return (-1)
        }
        let resource = json.data.translations[0].translatedText
        return resource
    }
}

extension TranslatorService {
    
    func swapTexts<T>(_ a: inout T, _ b: inout T){
        let A = a
        a = b
        b = A
    }
}
