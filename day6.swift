let input = [4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5]
var banks = input
var banksHash = 0
var memory = Set<Int>()
var distances = [Int : Int]()
var cycles = 0

repeat {
    // Save banks state to compare late
    memory.insert(banksHash)
    distances[banksHash] = cycles
    
    // In beginning of each cycle find max blocks
    var maxBlocks = 0
    var maxIndex = 0
    
    for (index, blocks) in banks.enumerated() {
        if blocks > maxBlocks {
            maxBlocks = blocks
            maxIndex = index
        }
    }
    
    // Get blocks from bank and set it to 0
    var blocks = banks[maxIndex]
    banks[maxIndex] = 0
    var index = maxIndex
    
    // Redistribute blocks
    while blocks > 0 {
        index += 1
        if (index >= banks.count) {
            index = 0
        }
        
        banks[index] += 1
        blocks -= 1
    }
    
    //Calculate hash of current banks state
    banksHash = banks.flatMap { String($0) }.joined().hashValue
    
    // Count cycles
    cycles += 1
} while !memory.contains(banksHash)

print(cycles)

var loopSize = memory.count - distances[banksHash]!

print(loopSize)