import Foundation

let input = """
0: 3
1: 2
4: 4
6: 4
"""

var severity = 0
var layers = [(Int, Int)]()

for line in input.replacingOccurrences(of: " ", with: "").split(separator: "\n") {
    let layer = line.split(separator: ":")
    
    guard let depth = Int(layer[0]), let range = Int(layer[1]) else { continue }
    
    if depth % (range + range - 2) == 0 {
        severity += range * depth
    }
    
    layers.append((depth, range))
}

print(severity)

var passed = false
var delay = 0

repeat {
    passed = true
    for (depth, range) in layers {
        if (depth + delay) % (range + range - 2) == 0 {
            passed = false
            delay += 1
            break
        }
    }
} while !passed

print(delay)