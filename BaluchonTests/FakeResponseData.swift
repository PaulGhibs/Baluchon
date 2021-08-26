//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Paul Ghibeaux on 18/08/2021.
//

import Foundation

// MARK: - Fake a server response
// The returned object is valid data from a .json file bundled in the application
class FakeResponseData {
    static var convertCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "translate", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
}

// MARK: - HTTP status code
extension FakeResponseData {
    // HTTP status code is 200
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    // HTTP status code is 500
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
}

// MARK: - Invalid data

extension FakeResponseData {
    static let IncorrectData = "erreur".data(using: .utf16)!
}

// MARK: - Error

extension FakeResponseData {
    class AnyError: Error {}
    static let error = AnyError()
}
