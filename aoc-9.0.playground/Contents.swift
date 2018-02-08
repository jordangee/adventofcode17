import Foundation

let input1 = "{}"
let input2 = "{{{}}}"
let input3 = "{{},{}}"
let input4 = "{{{},{},{{}}}}"
let input5 = "{<{},{},{{}}>}"
let input6 = "{<a>,<a>,<a>,<a>}"
let input7 = "{{<a>},{<a>},{<a>},{<a>}}"
let input8 = "{{<!>},{<!>},{<!>},{<a>}}"

func getGroupCount(_ input: String) -> Int {
    let canceledCharPattern = "!."
    let garbagePattern = "<[^>]*>"
    return input
        .removePattern(matching: canceledCharPattern)
        .removePattern(matching: garbagePattern)
        .filter { (char : Character) -> Bool in char == "{" }
        .count
}

extension String {
    func removePattern(matching pattern: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return self }
        var result = NSMutableString(string: self)
        regex.replaceMatches(in: result, range: NSMakeRange(0, result.length), withTemplate: "")
        return String(result)
    }
}

getGroupCount(input1) == 1
getGroupCount(input2) == 3
getGroupCount(input3) == 3
getGroupCount(input4) == 6
getGroupCount(input5) == 1
getGroupCount(input6) == 1
getGroupCount(input7) == 5
getGroupCount(input8) == 2
