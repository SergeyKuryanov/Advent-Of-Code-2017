let input = "{{<a!>},{<a!>},{<a!>},{<ab>}}"

var totalScore = 0
var groups = 0

var isSkipNext = false
var isInsideGarbarage = false

var garbarageCharacters = 0

for character in input {
    switch (character, isInsideGarbarage, isSkipNext) {
    case (_, _, true):
        isSkipNext = false
    case ("!", _, false):
        isSkipNext = true
    case ("{", false, false):
        groups += 1
        totalScore += groups
    case ("}", false, false):
        groups -= 1
    case ("<", false, false):
        isInsideGarbarage = true
    case (">", true, false):
        isInsideGarbarage = false
    case (_, true, false):
        garbarageCharacters += 1
    default:
        break
    }
}

print(totalScore)
print(garbarageCharacters)