let input = """
aa bb cc dd ee
aa bb cc dd aa
aa bb cc dd aaa
iiii oiii ooii oooi oooo
oiii ioii iioi iiio
"""

var validPasswords = 0

passwordLoop: for password in input.split(separator: "\n") {
    let phrases = password.split(separator: " ")

    for phraseIndex in 0..<phrases.count - 1{
        for compareIndex in phraseIndex + 1..<phrases.count {
            // For Part 2 just use .sorted(), phrases[index].sorted()
            let phrase = phrases[phraseIndex]
            let comparePhrase = phrases[compareIndex]

            if phrase == comparePhrase {
                continue passwordLoop;
            }
        }
    }

    validPasswords += 1
}

print(validPasswords)
