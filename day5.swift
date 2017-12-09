var input = [0, 3, 0, 1, -3];

var position = 0
var steps = 0

repeat {
    let offset = input[position]
    // For first part offsetChange = 1
    let offsetChange = offset >= 3 ? -1 : 1
    input[position] += offsetChange
    
    position += offset
    steps += 1
} while position >= 0 && position < input.count

print(steps)
