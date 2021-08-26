//
//  URLSessionFake.swift
//  BaluchonTests
//
//  Created by Paul Ghibeaux on 21/08/2021.
//  swiftlint:disable all

import Foundation
import XCTest

// Classical process of URL Session fake was showing depreciated error for ios 13
// The URLProtocol subclass allowing to intercept the network communication
// and provide custom mock responses for the given URLs.
final class TestURLProtocol: URLProtocol {
    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    //  just send back what we were given

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    // this dictionary maps URLRequests to test data
    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse, Error?))?

    override func startLoading() {
        // if we have a valid URL…
        guard let handler = TestURLProtocol.loadingHandler else {
            // fail if not
            XCTFail("Loading handler is not set.")
            return
        }
        // return the data response as handler
        let (data, response, error) = handler(request)
        if let data = data {
            // load protocol immediately with model

            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            // else fail with error
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }
    // this method is required but doesn't need to do anything
    override func stopLoading() {}
}
