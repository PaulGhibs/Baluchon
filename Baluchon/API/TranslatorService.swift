//
//  Translator.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation

// Translator API
// request translation and parse the result with service protocol

struct TranslatorService {
    // MARK: - Create request with extension API SERVICE
    static func createRequest(for text: String) -> URLRequest {
        // encoding url with percentages
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = Translate.url + encodedText!
        // url instance with parameters of structure Translate from services.swift
        let url = URL(string: completeURL)!
        var request = URLRequest(url: url)
        // enum instance from structure translate of services.swift
        request.httpMethod = MethodHttp.post.rawValue
        return request
    }
}

extension TranslatorService: ServiceProtocol {
    // PARSE the result with service protocol in Services
    static func parse(_ data: Data, with decoder: JSONDecoder) -> Any {
        // parse data from json or return -1 as resources for api service
        guard let json = try? decoder.decode(TranslatorJson.self, from: data) else {
            return (-1)
        }
        // and decode it as model from TranslatorJson -> translated text
        let resource = json.data.translations[0].translatedText
        return resource
    }
}
