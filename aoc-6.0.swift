var testBanks = [0, 2, 7, 0]
var realInput = [2, 8, 8, 5, 4, 2, 3, 1, 5, 5, 1, 2, 15, 13, 5, 14]

func calculateUniqueRedistributions(banks: [Int]) -> Int {
    var seenScenarios = [[Int]]()
    var currentScenario = banks
    var isRepeat: Bool {
        return seenScenarios.contains { $0 == currentScenario }
    }
    var redistributionCount = 0
    
    while !isRepeat || redistributionCount == 0 {
        seenScenarios.append(currentScenario)
        redistributionCount += 1
        let maxBank = currentScenario.max()!
        let maxIndex = currentScenario.index(of: maxBank)!
        var currentIndex = maxIndex + 1
        
        currentScenario[maxIndex] = 0
        for _ in 0..<maxBank {
            if currentIndex >= banks.count {
                currentIndex = 0
            }
            currentScenario[currentIndex] += 1
            currentIndex += 1
        }
        
        if isRepeat {
            break
        }
    }
    
    return redistributionCount
}

print(calculateUniqueRedistributions(banks: testBanks))
print(calculateUniqueRedistributions(banks: realInput))
