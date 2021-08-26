//
//  FakeWeatherURL.swift
//  BaluchonTests
//
//  Created by Paul Ghibeaux on 22/08/2021.
//

import Foundation

// The URLProtocol subclass allowing to intercept the network communication
// and provide custom mock responses for the given URLs.
class WeatherTestURLProtocol: URLProtocol {
  // The key-pairs of URLs this URLProtocol intercepts with their simulated response.
  static var mockResponses: [URL: (URLRequest) -> (result: Result<Data, Error>, statusCode: Int?)] = [:]
    // say we want to handle all types of request
  override class func canInit(with request: URLRequest) -> Bool {
    guard let url = request.url else { return false }
    return mockResponses.keys.contains(url.withoutQueryComponents)
  }
    //  just send back what we were given
  override func startLoading() {
    guard let responseBlock = WeatherTestURLProtocol.mockResponses[request.url!.withoutQueryComponents] else {
      fatalError("""
      No mock response for \(request.url!). This should never happen. Check
      the implementation of `canInit(with request: URLRequest) -> Bool`.
      """
      )
    }

    let response = responseBlock(request)

    // Simulate response on a background thread.
    DispatchQueue.global(qos: .default).async {
      if let code = response.statusCode {
        let httpURLResponse = HTTPURLResponse(
          url: self.request.url!,
          statusCode: code,
          httpVersion: nil,
          headerFields: nil
        )!

        self.client?.urlProtocol(self, didReceive: httpURLResponse, cacheStoragePolicy: .notAllowed)
      }

      switch response.result {
      case let .success(data):
        // Simulate received data.
        self.client?.urlProtocol(self, didLoad: data)
        // Finish loading (required).
        self.client?.urlProtocolDidFinishLoading(self)

      case let .failure(error):
        // Simulate error.
        self.client?.urlProtocol(self, didFailWithError: error)
      }
    }
  }

}

extension URL {
  // Returns the URL without its query components.
  fileprivate var withoutQueryComponents: URL {
    var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
    components.queryItems = nil
    return components.url!
  }
}
