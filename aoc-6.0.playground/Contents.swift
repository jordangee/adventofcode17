var testBanks = [0, 2, 7, 0]

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

calculateUniqueRedistributions(banks: testBanks) == 5

