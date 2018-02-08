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
    return input.canceledRemoved().garbageRemoved().filter { (char : Character) -> Bool in char == "{" }.count
}

extension String {
    func garbageRemoved() -> String {
        guard let regex = try? NSRegularExpression(pattern: "<[^>]*>") else { return self }
        var result = NSMutableString(string: self)
        regex.replaceMatches(in: result, range: NSMakeRange(0, result.length), withTemplate: "")
        return String(result)
    }
    
    func canceledRemoved() -> String {
        guard let regex = try? NSRegularExpression(pattern: "!.") else { return self }
        var result = NSMutableString(string: self)
        regex.replaceMatches(in: result, range: NSMakeRange(0, result.length), withTemplate: "")
        return String(result)
    }
}

input8.canceledRemoved() == "{{<},{<},{<},{<a>}}"

input1.garbageRemoved() == "{}"
input2.garbageRemoved() == "{{{}}}"
input3.garbageRemoved() == "{{},{}}"
input4.garbageRemoved() == "{{{},{},{{}}}}"
input5.garbageRemoved() == "{}"
input6.garbageRemoved() == "{,,,}"
input7.garbageRemoved() == "{{},{},{},{}}"
input8.garbageRemoved() == "{{},{},{},{}}"

getGroupCount(input1) == 1
getGroupCount(input2) == 3
getGroupCount(input3) == 3
getGroupCount(input4) == 6
getGroupCount(input5) == 1
getGroupCount(input6) == 1
getGroupCount(input7) == 5
getGroupCount(input8) == 2
