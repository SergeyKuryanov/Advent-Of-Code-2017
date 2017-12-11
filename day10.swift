import Foundation

extension Array {
    func circularIndex(_ index: Int) -> Int {
        if index >= self.count {
            return index % self.count
        } else {
            return index
        }
    }
}

func reverse(array: inout [Int], from index: Int, length: Int) {
    guard array.count >= length, length > 1 else { return }
    
    let newIndex = index + length - 1
    
    // Subrange to the end of array or to new index
    var subrange = array[index...Swift.min(array.count - 1, newIndex)]
    // Add remaining indicies from beginning of array
    if newIndex >= array.count {
        subrange += array[0...array.circularIndex(newIndex)]
    }
    let reversed = ArraySlice(subrange.reversed())
    
    let indicesToEnd = array.count - 1 - index
    
    if indicesToEnd >= reversed.count - 1 {
        array[index..<index + reversed.count] = reversed
    } else {
        // Add indicies to end and to the beginning
        array[index..<array.count] = reversed[0...indicesToEnd]
        array[0...array.circularIndex(newIndex)] = reversed[indicesToEnd + 1..<reversed.count]
    }
}

let input = "230,1,2,221,97,252,168,169,57,99,0,254,181,255,235,167"
var knots = Array(0...255)
var skip = 0
var position = 0

for lengthString in input.split(separator: ",") {
    guard let length = Int(lengthString) else { continue }
    
    reverse(array: &knots, from: position, length: length)
    position = knots.circularIndex(position + length + skip)
    skip += 1
}

print(knots[0] * knots[1])

var anciiBytes = input.unicodeScalars.map { $0.value }
anciiBytes += [17, 31, 73, 47, 23]

var sparseHash = Array(0...255)
skip = 0
position = 0

for _ in 0..<64 {
    for byte in anciiBytes {
        let length = Int(byte)
        reverse(array: &sparseHash, from: position, length: length)
        position = sparseHash.circularIndex(position + length + skip)
        skip += 1
    }
}

var denseHash = [Int]()

for i in stride(from: 0, to: sparseHash.count, by: 16) {
    let hashPart = sparseHash[i..<i + 16].reduce(0, { $0 ^ $1 })
    denseHash.append(hashPart)
}

let hash = denseHash.map { String(format:"%02x", $0) }.joined()
print(hash)