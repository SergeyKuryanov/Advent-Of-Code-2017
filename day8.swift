let input = """
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
"""

var registers = [String: Int]()
var maxRegisterValue = 0

func value(of register: String) -> Int {
    return registers[register] ?? 0
}

func eval(_ operation: String) -> (Int, Int) -> Bool {
    switch operation {
    case ">":
        return (>)
    case "<":
        return (<)
    case ">=":
        return (>=)
    case "<=":
        return (<=)
    case "==":
        return (==)
    case "!=":
        return (!=)
    default:
        return (==)
    }
}

func perform(operation: String, register: String, amount: Int) {
    var registerValue = value(of: register)
    
    switch operation {
    case "inc":
        registerValue += amount
    default:
        registerValue -= amount
    }
    
    registers[register] = registerValue
    
    maxRegisterValue = max(maxRegisterValue, registerValue)
}

for inputString in input.split(separator: "\n") {
    let instructions = inputString.split(separator: " ")
    let register = String(instructions[0])
    let operation = String(instructions[1])
    guard let amount = Int(instructions[2]) else { continue }
    
    let conditionRegister = String(instructions[4])
    let conditionOperator = String(instructions[5])
    guard let conditionValue = Int(instructions[6]) else { continue }
    
    if eval(conditionOperator)(value(of: conditionRegister), conditionValue) {
        perform(operation: operation, register: register, amount: amount)
    }
}

if let greatestRegister = registers.max (by: { $0.value < $1.value  }) {
    print(greatestRegister)
}

print(maxRegisterValue)