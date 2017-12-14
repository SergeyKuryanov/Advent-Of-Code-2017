import Foundation

let input = """
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
"""

class Program: Equatable, Hashable {
    let number: Int
    let pipes: [Int]
    var connectedPrograms = Set<Program>()
    
    init(number: Int, pipes: [Int]) {
        self.number = number
        self.pipes = pipes
    }
    
    var hashValue: Int {
        return number.hashValue
    }
    
    static func == (lhs: Program, rhs: Program) -> Bool {
        return lhs.number == rhs.number
    }
    
    func allConnectedPrograms(excluding: Set<Program> = []) -> Set<Program> {
        var childPrograms = Set([self]).union(connectedPrograms)
        for childProgram in connectedPrograms.subtracting(excluding) {
            if childProgram == self { continue }
            
            childPrograms.formUnion(childProgram.allConnectedPrograms(excluding: excluding.union(childPrograms)))
        }
        return childPrograms
    }
}

var programs = [Program]()

for line in input.replacingOccurrences(of: ",", with: "").split(separator: "\n") {
    let components = line.split(separator: " ")
    guard let number = Int(components[0]) else { continue }
    let pipes = components[2..<components.count].flatMap { Int($0) }
    
    programs.append(Program(number: number, pipes: pipes))
}

for program in programs {
    for pipe in program.pipes {
        programs[pipe].connectedPrograms.insert(program)
    }
}

print(programs[0].allConnectedPrograms().count)

var groups = 0
var groupedPrograms = Set(programs)

while groupedPrograms.count > 0 {
    groups += 1;
    
    groupedPrograms.first?.allConnectedPrograms().forEach { groupedPrograms.remove($0) }
}

print(groups)
