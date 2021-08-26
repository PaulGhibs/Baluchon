//
//  APIRequests.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 12/08/2021.
//

import Foundation

// Perform API requests
class APIService {
    // A closure to provide the state of a network call to the ViewControllers
    typealias Callback = (Bool, Any?) -> Void
    var request: URLRequest?
    // Decoded data from an API
    var resource: Any?
    static var shared = APIService()
    private init() {}
    private var task: URLSessionDataTask?
    // for testing purpose
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
}

extension APIService {
    // Query request shared sent to controllers, will be true if succes, false if an error is present or incorrect data
    func query(API: Services, input: String = "", callback: @escaping Callback) {
        // Perform a request from extension with input of user or return a callback(false, nil)
        guard let request = getRequest(API: API, for: input) else {
            callback(false, nil)
            return
        }
        // Perform a session dataTask with URLRequest to different APIs
        task = session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                // if no data or an error is present return callback(false,nil)
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                // if response is not 200 return callback(false,nil)
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                // Instance for json decoder
                let decoder = JSONDecoder()
                switch API {
                // parse resource of fixer, and translate services or return callback with false and nil
                case .fixer:
                    if ConversionService.parse(data, with: decoder) as? Int == -1 ||
                        ConversionService.parse(data, with: decoder) as? Int == -2 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = ConversionService.parse(data, with: decoder)
                case .translate:
                    if TranslatorService.parse(data, with: decoder) as? Int == -1 {
                        callback(false, nil)
                        return
                    }
                    self?.resource = TranslatorService.parse(data, with: decoder)
                }
                // if no data or an error for resource is present return callback(false,nil)
                callback(true, self?.resource)
            }
        }
        task?.resume()
    }
}

extension APIService {
    //  Call 'createRequest' for API fixer and translate
    //  Any value input by the user and used by the API to provide the expected resource
    private func getRequest(API: Services, for input: String = "") -> URLRequest? {
        switch API {
        case .fixer:
            request = ConversionService.getConversion()
        case .translate:
            request = TranslatorService.createRequest(for: input)
        }
        return request
    }
}
