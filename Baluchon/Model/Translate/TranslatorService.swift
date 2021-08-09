//
//  Translator.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 01/08/2021.
//

import Foundation

// Translator API
class TranslatorAPI {
    // MARK: - Properties

    private init() {}
    static var shared = TranslatorAPI()
    private static let translationURL = URL(string: "https://translation.googleapis.com/language/translate/v2/")!
    private static let translationAPIKey = Constants.valueAPIKey("apiTranslate")
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
}

extension TranslatorAPI{
    // MARK: - Methods

    func getTranslation(q: String, source: String, target: String, callback: @escaping (Bool,String?) -> Void){
        let encodeUserEntry = q.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let fullURL = TranslatorAPI.translationURL.absoluteString + "?q=\(encodeUserEntry!)&source=\(source)&target=\(target)&key=\(TranslatorAPI.translationAPIKey)"
        var request = URLRequest(url: URL(string: fullURL)!)
        request.httpMethod = "GET"
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else{
                    return callback(false, nil)
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }
                do {
                    let responseJSON = try JSONDecoder().decode(LanguageOrigin.self, from: data)
                    let translationResult = responseJSON.data.translations[0].translatedText
                    callback(true, translationResult)
                }
                catch{
                    return callback(false, nil)
                }
            }
        }
        task?.resume()
    }
    
}

extension TranslatorAPI{
    
    func swapTexts<T>(_ a: inout T, _ b: inout T){
        let A = a
        a = b
        b = A
    }
}
