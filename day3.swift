let input = 312051

// In our case max loop value will be in bottom right corner
var bottomRightCorner = 1 // Spiral starting number
var loop = 0

// Each loop is bigger than previous one by 8
repeat {
    loop += 1
    bottomRightCorner += loop * 8 // Calculate last number in each loop
    
} while bottomRightCorner < input //  Determine overal number or loops

// Size of each side bigger than previous by 2, starting from 1
let sideSize = 1 + loop * 2

// Distance from corner to center
let centerDistance = sideSize / 2

var corner = bottomRightCorner
var cornerDistance = sideSize

// Calculate nearest corner distance
repeat {
    cornerDistance = abs(corner - input)
    corner -= sideSize - 1
} while cornerDistance > centerDistance

// Distract corner distance from max distance
let maxDistance = centerDistance + loop
let distance = maxDistance - cornerDistance

print(distance)