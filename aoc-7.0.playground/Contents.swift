import Foundation

class Node {
    let name: String
    let weight: Int
    let childNames: [String]
    var childNodes = [Node]()
    
    init(name: String, weight: Int, childNames: [String]) {
        self.name = name
        self.weight = weight
        self.childNames = childNames
    }
}

extension Node : CustomStringConvertible {
    
    func stringify(withIndent indent: Int) -> String {
        var space = String.init(repeating: " ", count: indent * 2)
        var result = space + "Node(\(name), \(weight)) [\(childNodes.count > 0 ? "\n" : "")"
        childNodes.forEach {
            result += $0.stringify(withIndent: indent + 1) + "\n"
        }
        result += "\(childNodes.count > 0 ? space : "")]"
        return result
    }
    
    var description: String {
        return stringify(withIndent: 0)
    }
}

let tower = """
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
"""

let tower2 = tower.split(separator: "\n")
    .map {
        $0.replacingOccurrences(of: " -> ", with: ">")
            .replacingOccurrences(of: ", ", with: ",")
            .split(separator: ">")
            .map {
                $0.replacingOccurrences(of: " (", with: "(")
                    .split(separator: "(")
                    .map { $0.replacingOccurrences(of: ")", with: "") }
            }
    }
    .map {
        (thing: [[String]]) -> Node in
        let childNames = thing.count == 2 ? thing[1][0].split(separator: ",").map(String.init) : [String]()
        return Node(name: thing.first![0], weight: Int(thing.first![1])!, childNames: childNames)
    }

let towerDict = tower2
    .reduce([String : Node]()) {
        var newDict = $0
        newDict[$1.name] = $1
        return newDict
    }

for tower in tower2 {
    tower.childNodes = tower.childNames.map { towerDict[$0]! }
}

var nameArray = [String]()
tower2.forEach {
    if $0.childNodes.count > 0 {
        print($0)
    }
    
    nameArray.append($0.name)
    for childNode in $0.childNodes {
        nameArray.append(childNode.name)
    }
}

var root = ""
nameArray = nameArray.sorted()
for i in stride(from: 0, to: nameArray.count, by: 2) {
    if nameArray[i] != nameArray[i + 1] {
        root = String(nameArray[i])
        break
    }
}
print(root)
