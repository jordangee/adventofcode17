import Foundation

let input1 = "{}"
let input2 = "{{{}}}"
let input3 = "{{},{}}"
let input4 = "{{{},{},{{}}}}"
let input5 = "{<a>,<a>,<a>,<a>}"
let input6 = "{{<ab>},{<ab>},{<ab>},{<ab>}}"
let input7 = "{{<!!>},{<!!>},{<!!>},{<!!>}}"
let input8 = "{{<a!>},{<a!>},{<a!>},{<ab>}}"

func getTotalScore(_ input: String) -> Int {
    let filteredInput = input.filterInput()
    return filteredInput.score()
}

extension String {
    func removePattern(matching pattern: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return self }
        var result = NSMutableString(string: self)
        regex.replaceMatches(in: result, range: NSMakeRange(0, result.length), withTemplate: "")
        return String(result)
    }
    
    func filterInput() -> String {
        let canceledCharPattern = "!."
        let garbagePattern = "<[^>]*>"
        return self
            .removePattern(matching: canceledCharPattern)
            .removePattern(matching: garbagePattern)
    }
    
    func score() -> Int {
        var totalScore = 0
        var nextScore = 1
        for char in self {
            if char == "{" {
                totalScore += nextScore
                nextScore += 1
            }
            if char == "}" {
                nextScore -= 1
            }
        }
        return totalScore
    }
}

getTotalScore(input1) == 1
getTotalScore(input2) == 6
getTotalScore(input3) == 5
getTotalScore(input4) == 16
getTotalScore(input5) == 1
getTotalScore(input6) == 9
getTotalScore(input7) == 9
getTotalScore(input8) == 3
