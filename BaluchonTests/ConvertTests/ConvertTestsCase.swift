//
//  ConvertTestsCase.swift
//  BaluchonTests
//
//  Created by Paul Ghibeaux on 18/08/2021.
//

import XCTest

@testable import Baluchon

class ConvertTestsCase: XCTestCase {
    func testGivenValueaRateforConvertShouldReturn1() {
        //given
        let value = 3.0
        let rate = 3.0
        //when
        let result = ConversionJson.convert(value, with: rate)
        //then
        XCTAssertEqual(result, "1.00")
    }
   
}
