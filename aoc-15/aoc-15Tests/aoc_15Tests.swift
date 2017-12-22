//
//  aoc_15Tests.swift
//  aoc-15Tests
//
//  Created by dev1 on 12/22/17.
//  Copyright © 2017 Asynchrony. All rights reserved.
//

import XCTest
@testable import aoc_15

class aoc_15Tests: XCTestCase {
    func test_GeneratorA_generates_correct_values() {
        var testObject = Generator(seed: 65, factor: 16807)
        
        XCTAssertEqual(testObject.next(), 1092455)
        XCTAssertEqual(testObject.next(), 1181022009)
        XCTAssertEqual(testObject.next(), 245556042)
        XCTAssertEqual(testObject.next(), 1744312007)
        XCTAssertEqual(testObject.next(), 1352636452)
        
        testObject = Generator(seed: 1, factor: 16807)
        
        XCTAssertEqual(testObject.next(), 16807)
    }
    
    func test_GeneratorB_generates_correct_values() {
        var testObject = Generator(seed: 8921, factor: 48271)
        
        XCTAssertEqual(testObject.next(), 430625591)
        XCTAssertEqual(testObject.next(), 1233683848)
        XCTAssertEqual(testObject.next(), 1431495498)
        XCTAssertEqual(testObject.next(), 137874439)
        XCTAssertEqual(testObject.next(), 285222916)
        
        testObject = Generator(seed: 1, factor: 48271)
        
        XCTAssertEqual(testObject.next(), 48271)
    }

    func test_Judge_returns_true_when_values_match() {
        var testObject = Judge()
        
        XCTAssertEqual(true, testObject.valuesMatch(0, 0))
        XCTAssertEqual(true, testObject.valuesMatch(1, 1))
        XCTAssertEqual(true, testObject.valuesMatch(2, 2))
        XCTAssertEqual(true, testObject.valuesMatch(2147483646, 2147483646))
    }
    
    func test_Judge_returns_false_when_lower_16_bits_of_values_do_not_match() {
        var testObject = Judge()
        
        XCTAssertEqual(false, testObject.valuesMatch(0, 1))
        XCTAssertEqual(false, testObject.valuesMatch(1, 2))
        XCTAssertEqual(false, testObject.valuesMatch(2, 0))
        XCTAssertEqual(false, testObject.valuesMatch(2147483646, 1431495498))
    }
    
    func test_Judge_returns_true_when_lower_16_bits_of_values_do_match() {
        var testObject = Judge()
        
        XCTAssertEqual(true, testObject.valuesMatch(0x70001, 0x80001))
        XCTAssertEqual(true, testObject.valuesMatch(0xff0000, 0xface0000))
        XCTAssertEqual(true, testObject.valuesMatch(0xffcafe, 0xfacecafe))
        XCTAssertEqual(true, testObject.valuesMatch(245556042, 1431495498))
    }
    
    func test_Judge_returns_true_when_generator_values_match() {
        var testObject = Judge()
        var generatorA = Generator(seed: 65, factor: 16807)
        var generatorB = Generator(seed: 8921, factor: 48271)

        XCTAssertEqual(false, testObject.valuesMatch(generatorA.next(), generatorB.next()))
        XCTAssertEqual(false, testObject.valuesMatch(generatorA.next(), generatorB.next()))
        XCTAssertEqual(true, testObject.valuesMatch(generatorA.next(), generatorB.next()))
        XCTAssertEqual(false, testObject.valuesMatch(generatorA.next(), generatorB.next()))
        XCTAssertEqual(false, testObject.valuesMatch(generatorA.next(), generatorB.next()))
    }
    
    func test_Judge_counts_number_of_matches() {
        var testObject = Judge()
        var generatorA = Generator(seed: 65, factor: 16807)
        var generatorB = Generator(seed: 8921, factor: 48271)
        
        XCTAssertEqual(testObject.numMatches, 0)
        
        for _ in 1...5 {
            _ = testObject.valuesMatch(generatorA.next(), generatorB.next())
        }
        
        XCTAssertEqual(testObject.numMatches, 1)
    }
    
    func test_Judge_counts_number_of_matches_with_lots_o_matches() {
        var testObject = Judge()
        var generatorA = Generator(seed: 65, factor: 16807)
        var generatorB = Generator(seed: 8921, factor: 48271)
        
        XCTAssertEqual(testObject.numMatches, 0)
        
        for _ in 1...40000000 {
            _ = testObject.valuesMatch(generatorA.next(), generatorB.next())
        }
        
        XCTAssertEqual(testObject.numMatches, 588)
    }
    
    func test_part1() {
        var testObject = Judge()
        var generatorA = Generator(seed: 883, factor: 16807)
        var generatorB = Generator(seed: 879, factor: 48271)
        
        XCTAssertEqual(testObject.numMatches, 0)
        
        for _ in 1...40000000 {
            _ = testObject.valuesMatch(generatorA.next(), generatorB.next())
        }
        
        XCTAssertEqual(testObject.numMatches, 0)
    }
}
