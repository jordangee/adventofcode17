import Foundation
// only works with single digit numbers


let testInput = """
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
"""

func calculateProgramsInGroup(_ input: String) -> Int {
    let strArr = input.replacingOccurrences(of: " <->", with: "").replacingOccurrences(of: ",", with: "")
        .split(separator: "\n")

    let blah = strArr.map { $0.split(separator: " ") }
    let blah2 = blah.map { $0.flatMap { Int($0) } }
    print(blah2)
    
    var numInGroup = Set<Int>()
    numInGroup.insert(0)
    
    blah2.forEach {
        for num in numInGroup {
            if $0.contains(num) {
                $0.forEach { numInGroup.insert($0) }
            }
        }
    }
    
    print(numInGroup)
    print(numInGroup.count)
    
    return numInGroup.count
}

calculateProgramsInGroup(testInput) == 6
