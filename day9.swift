let input = "{{<a!>},{<a!>},{<a!>},{<ab>}}"

var totalScore = 0
var groups = 0

var skipNext = false
var isInsideGarbarage = false

var garbarageCharacters = 0

for character in input {
    if skipNext {
        skipNext = false
        continue
    }
    
    switch character {
    case "{" where !isInsideGarbarage:
        groups += 1
        totalScore += groups
    case "}" where !isInsideGarbarage:
        groups -= 1
    case "<" where !isInsideGarbarage:
        isInsideGarbarage = true
    case ">" where isInsideGarbarage:
        isInsideGarbarage = false
    case "!":
        skipNext = true
    case _ where isInsideGarbarage:
        garbarageCharacters += 1
    default:
        break
    }
}

print(totalScore)
print(garbarageCharacters)