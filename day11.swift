let input = "se,sw,se,sw,sw"

struct Coordinates {
    var x: Int
    var y: Int
    var z: Int
    
    var distance: Int {
        return (abs(x) + abs(y) + abs(z)) / 2
    }
    
    static func + (left: Coordinates, right: (x: Int, y: Int, z: Int)) -> Coordinates {
        return Coordinates(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }
    
    static func += (left: inout Coordinates, right: (x: Int, y: Int, z: Int)) {
        left = left + right
    }
}

var coordinates = Coordinates(x: 0, y: 0, z: 0)
var maxDistance = 0

for direction in input.split(separator: ",") {
    switch direction {
    case "n":
        coordinates += (0, 1, -1)
    case "ne":
        coordinates += (1, 0, -1)
    case "se":
        coordinates += (1, -1, 0)
    case "s":
        coordinates += (0, -1, 1)
    case "sw":
        coordinates += (-1, 0, 1)
    case "nw":
        coordinates += (-1, 1, 0)
    default:
        break
    }
    
    maxDistance = max(maxDistance, coordinates.distance)
}

print(coordinates.distance, maxDistance)