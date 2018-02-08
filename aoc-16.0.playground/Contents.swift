var testPrograms = "abcde"
let testDance = "s1,x3/4,pe/b"

func executeDance (_ input: String) -> String {
    let danceArr = input.split(separator: ",")
    for substring in danceArr {
        switch String(substring.first!) {
        case "s":
            spin(String(substring[substring.index(after: substring.startIndex)...]))
        case "x":
            exchange(String(substring[substring.index(after: substring.startIndex)...]))
        case "p":
            partner(String(substring[substring.index(after: substring.startIndex)...]))
        default:
            continue
        }
        print(testPrograms)
    }
    return input
}

func spin(_ instr: String) {
    guard let size = Int(instr) else { return }
    testPrograms = String(testPrograms.suffix(size) + testPrograms.prefix(testPrograms.count - size))
}

func exchange(_ instr: String) {
    let indexArr = instr.split(separator: "/")
    guard let firstInt = Int(indexArr[0]), let secondInt = Int(indexArr[1]) else { return }
    let firstIndex = testPrograms.index(testPrograms.startIndex, offsetBy: firstInt)
    let secondIndex = testPrograms.index(testPrograms.startIndex, offsetBy: secondInt)
    let firstChar = testPrograms[firstIndex]
    let secondChar = testPrograms[secondIndex]
    testPrograms = String(testPrograms.map {
        if $0 == firstChar { return secondChar }
        if $0 == secondChar { return firstChar }
        return $0
    })
}

func partner(_ instr: String) {
    let charArr = instr.split(separator: "/")
    let firstChar = charArr[0].first!
    let secondChar = charArr[1].first!
    testPrograms = String(testPrograms.map {
        if $0 == firstChar { return secondChar }
        if $0 == secondChar { return firstChar }
        return $0
    })
}

executeDance(testDance) == "baedc"
