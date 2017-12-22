//
//  Generator.swift
//  aoc-15
//
//  Created by dev1 on 12/22/17.
//  Copyright © 2017 Asynchrony. All rights reserved.
//

import Foundation

struct Generator {
    let factor: Int
    var currentValue: Int
    let divisor: Int
    
    init(seed: Int, factor: Int, divisor: Int = 1) {
        self.factor = factor
        self.currentValue = seed
        self.divisor = divisor
    }
    
    mutating func next() -> Int {
        currentValue = (currentValue * factor) % 2147483647

        return currentValue % divisor == 0 ? currentValue : self.next()
    }
}
