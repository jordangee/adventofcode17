//
//  aoc_15_2_Tests.swift
//  aoc-15Tests
//
//  Created by dev1 on 12/22/17.
//  Copyright © 2017 Asynchrony. All rights reserved.
//

import XCTest
@testable import aoc_15

class aoc_15_2_Tests: XCTestCase {

/*
--Gen. A--  --Gen. B--
1352636452  1233683848
1992081072   862516352
530830436  1159784568
1980017072  1616057672
740335192   412269392
*/
    
    func test_GeneratorA_only_returns_multiples_of_4() {
        var testObject = Generator(seed: 65, factor: 16807, divisor: 4)
        
        XCTAssertEqual(testObject.next(), 1352636452)
        XCTAssertEqual(testObject.next(), 1992081072)
        XCTAssertEqual(testObject.next(), 530830436)
        XCTAssertEqual(testObject.next(), 1980017072)
        XCTAssertEqual(testObject.next(), 740335192)
    }
}
