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
    let offsetsArray = offsetsString.split(separator: "\n")

    var offsets = offsetsArray.flatMap { Int(String($0)) }

    var currentPointIndex = 0
    var currentPointNumber = 0
    var jumps = 0

    while currentPointIndex < offsets.count {
        currentPointNumber = offsets[currentPointIndex]
        if currentPointNumber < 3 {
            offsets[currentPointIndex] += 1
        } else {
            offsets[currentPointIndex] -= 1
        }
        currentPointIndex += currentPointNumber

        print(offsets)
        jumps += 1
    }
    
    return jumps
}

countJumps(offsetsString) == 10
