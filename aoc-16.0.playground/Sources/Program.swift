import Foundation

public class Program {
    public private(set) var internalState: String
    
    public init(state: String) {
        internalState = state
    }
    
    public func executeDance(_ danceMoves: String) {
        let danceArr = danceMoves.split(separator: ",")

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
        }
    }
    
    func spin(_ instr: String) {
        guard let size = Int(instr) else { return }
        //        print("spin \(size)")
        internalState = String(internalState.suffix(size) + internalState.prefix(internalState.count - size))
    }
    
    func exchange(_ instr: String) {
        let indexArr = instr.split(separator: "/")
        guard let firstInt = Int(indexArr[0]), let secondInt = Int(indexArr[1]) else { return }
        //        print("exchange \(firstInt) / \(secondInt)")
        let firstIndex = internalState.index(internalState.startIndex, offsetBy: firstInt)
        let secondIndex = internalState.index(internalState.startIndex, offsetBy: secondInt)
        internalState = internalState.swap(internalState[firstIndex], internalState[secondIndex])
    }
    
    func partner(_ instr: String) {
        let charArr = instr.split(separator: "/")
        let firstChar = charArr[0].first!
        let secondChar = charArr[1].first!
        //        print("partner \(firstChar) / \(secondChar)")
        internalState = internalState.swap(firstChar, secondChar)
    }
    
}

extension String {
    func swap(_ firstChar: Character, _ secondChar: Character) -> String {
        return String(self.map {
            if $0 == firstChar { return secondChar }
            if $0 == secondChar { return firstChar }
            return $0
        })
    }
}
