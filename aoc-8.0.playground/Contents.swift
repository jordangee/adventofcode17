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

findLargestRegister(sampleInput)
