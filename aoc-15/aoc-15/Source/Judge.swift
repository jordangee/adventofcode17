//
//  Judge.swift
//  aoc-15
//
//  Created by dev1 on 12/22/17.
//  Copyright © 2017 Asynchrony. All rights reserved.
//

import Foundation

struct Judge {
    var numMatches = 0
    
    mutating func valuesMatch(_ value1: Int, _ value2: Int) -> Bool {
        let maskValue = 0xffff0000
        let isMatch = (value1 | maskValue) == (value2 | maskValue)
        if isMatch {
            numMatches += 1
        }
        return isMatch
    }
}
