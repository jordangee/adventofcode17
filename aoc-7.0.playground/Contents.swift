import Foundation

struct Node {
    let name: String
    let weight: Int
    let childNodes: [String]
}

extension Node : CustomStringConvertible {
    var description: String {
        return "Node(\(name), \(weight), \(childNodes))"
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
    .map { $0.replacingOccurrences(of: " -> ", with: ">").split(separator: ">")
        .map { $0.replacingOccurrences(of: " (", with: "(")
            .split(separator: "(").map { $0.replacingOccurrences(of: ")", with: "") }
        } }
    .map { Node(name: $0.first![0], weight: Int($0.first![1])!, childNodes: $0.count == 2 ? $0[1] : []) }


tower2.forEach { print($0) }

