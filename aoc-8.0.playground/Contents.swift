import Foundation

var registerDict = [String : Int]()

struct Instruction {
    let registerToChange: String
    let direction: String
    let amountToChange: Int
    let registerToCheck: String
    let operatorValue: String
    let checkValue: Int
}

extension Instruction: CustomStringConvertible {
    var description: String {
        return "Register to change: \(registerToChange), Direction: \(direction), Amount to change: \(amountToChange) | Register to check: \(registerToCheck), Operator: \(operatorValue), Check value: \(checkValue)"
    }
}


let sampleInput = """
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
"""

let sampleInput2 = """
y inc 497 if n <= 3
ig inc -54 if es < 9
j dec 278 if low < 10
nm inc -531 if tr == 0
tq inc 537 if tq < 9
txm dec 835 if s != -8
xho dec -204 if vv < 6
ipq dec 59 if txm != -835
vv dec -259 if xho <= 210
tq inc 364 if qen != -7
xho inc -198 if xho < 205
afo dec -182 if j == -278
qen inc 774 if ntk == 4
cwp dec -414 if tr < 4
vv dec -696 if ntk == 0
low dec 851 if n == 0
tq inc -132 if t > -10
mux dec 626 if j >= -283
wby dec 759 if vv >= 950
qen inc 853 if j >= -283
qen inc -571 if tr != 0
ntk inc 213 if n == 0
"""

func findLargestRegister(_ instructionsString: String) -> String {
    var largestRegister = "default"
    let formattedInstructions = instructionsString.replacingOccurrences(of: " if", with: ":")
    
    let instructions = formattedInstructions.split(separator: "\n").map { $0.split(separator: ":") }
    
    let data = instructions.map { $0[0].split(separator: " ") }
    let condition = instructions.map { $0[1].split(separator: " ") }
    
    var instrArray = [Instruction]()
    
    for i in 0..<instructions.count {
        let data = data[i]
        let condition = condition[i]
        let instruction = Instruction(registerToChange: String(data[0]), direction: String(data[1]), amountToChange: Int(data[2])!,
                                      registerToCheck: String(condition[0]), operatorValue: String(condition[1]), checkValue: Int(condition[2])!)
        instrArray.append(instruction)
    }
    
    instrArray.forEach { executeInstruction($0) }
    
    if let maxValue = registerDict.values.max() {
        
        if let index = registerDict.values.index(of: maxValue) {
            let key = registerDict.keys[index]
            largestRegister = key
        }
    }
    
    registerDict.sorted(by: <).forEach {print($0)}

    var registerArr = [String]()
    instrArray.forEach { registerArr.append($0.registerToChange) }
    let set: Set = Set(registerArr)
    
    let sortedSet = set.sorted()
    print(sortedSet)
    
    return largestRegister
}

func executeInstruction(_ instruction: Instruction) {
    var registerCheckValue = 0
    if let existingRegisterValue = registerDict[instruction.registerToCheck] {
        registerCheckValue = existingRegisterValue
    }
    
    var registerChangeValue = 0
    if checkCondition(registerCheckValue, instruction.operatorValue, instruction.checkValue) {
        if let existingRegisterValue = registerDict[instruction.registerToChange] {
            registerChangeValue = existingRegisterValue
        }
        
        let changedAmount = calculateChangeAmount(registerChangeValue, instruction.direction, instruction.amountToChange)

        registerDict[instruction.registerToChange] = changedAmount
    }
}

func calculateChangeAmount(_ registerValue: Int, _ direction: String, _ amountToChange: Int) -> Int {
    let addedAmount = direction == "inc" ? amountToChange * 1 : amountToChange * -1
    return registerValue + addedAmount
}

func checkCondition(_ registerValue: Int, _ condition: String, _ checkValue: Int) -> Bool {
    //ugh prob a better way to do this
    switch condition {
    case ">":
        return registerValue > checkValue
    case "<":
        return registerValue < checkValue
    case ">=":
        return registerValue >= checkValue
    case "<=":
        return registerValue <= checkValue
    case "==":
        return registerValue == checkValue
    case "!=":
        return registerValue != checkValue
    default:
        return true
    }
}

//findLargestRegister(sampleInput)
findLargestRegister(sampleInput2)
