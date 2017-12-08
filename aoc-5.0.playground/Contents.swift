//: Playground - noun: a place where people can play

import Cocoa

var offsetsString = """
0
3
0
1
-3
"""

func countJumps(_ offsetsString: String) -> Int {
    var offsetsArray = offsetsString.split(separator: "\n")

    var offsets = offsetsArray.flatMap { Int(String($0)) }

    var start = offsets.startIndex
    var currentPointIndex = 0
    var testIndex = 0
    var currentPointNumber = 0
    var jumps = 0

    while testIndex < offsets.count {
        currentPointNumber = offsets[testIndex]
        offsets[testIndex] += 1
        testIndex += currentPointNumber

        print(offsets)
        jumps += 1
    }
    
    return jumps
}

countJumps(offsetsString) == 5
