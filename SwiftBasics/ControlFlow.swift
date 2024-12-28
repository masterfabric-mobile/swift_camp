// For in loop

var myArray = [1, 2, 3, 4, 5]

for number in myArray {
    print(number)
}

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}


let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}


let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

print("\(base) to the power of \(power) is \(answer)")


let hours = 12
let hourInterval = 3


// While loop

var square = 0
var diceRoll = 0
while (square < 25) {
    square += diceRoll
    diceRoll += 1
    print("Square: \(square), Dice Roll: \(diceRoll)")
}


// Repeat-While loop

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square1 = 0
var diceRoll1 = 0
let maxAttempts = 100
var attempts = 0

repeat {
    let nextSquare = square1 + board[square1]
    if nextSquare <= square1 || attempts >= maxAttempts {
        print("Stuck in a loop or too many attempts! Exiting.")
        break
    }
    square1 = nextSquare
    diceRoll1 += 1
    attempts += 1
    print("Square: \(square1), Dice Roll: \(diceRoll1)")
} while square1 < finalSquare

print("Game over!")

// Conditional Statements
// If statement

let temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}



let weatherAdvice = if temperatureInFahrenheit <= 32 {
    "It's very cold. Consider wearing a scarf."
} else if temperatureInFahrenheit >= 86 {
    "It's really warm. Don't forget to wear sunscreen."
} else {
    "It's not that cold. Wear a t-shirt."
}


// Switch statement

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}


// No implicit fallthrough

// --> at here we can see that the switch statement does not fall through the cases.
// It is not necessary to break out of the switch statement after each case.
// The switch statement does this automatically.

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a":
    print("The letter A")
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}


// Interval Matching

let approximateCount = 62
let countedThings = "moons orbiting Jupiter"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

print("There are \(naturalCount) \(countedThings).") // prints "There are dozens of moons orbiting Jupiter."



// Tuples

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}


// Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}



// Compound Cases
let someCharacter1: Character = "e"
switch someCharacter1 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter1) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter1) is a consonant")
default:
    print("\(someCharacter1) is not a vowel or a consonant")
}


// Control Transfer Statements


let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]


for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    } else {
        puzzleOutput.append(character)
    }
    print(puzzleOutput) // prints  g -> gr -> grt -> grtm -> grtmnds -> grtmndsthnk -> grtmndsthnklk

}


// Break in a loop statement

let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}

if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}


// Fallthrough

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
fallthrough
default:
    description += " an integer."
}

print(description) // prints "The number 5 is a prime number, and also an integer."


// Labeled Statements

let finalSquare2 = 25
var board2 = [Int](repeating: 0, count: finalSquare2 + 1)
board2[03] = +08; board2[06] = +11; board2[09] = +09; board2[10] = +02
board2[14] = -10; board2[19] = -11; board2[22] = -02; board2[24] = -08
var square2 = 0
var diceRoll2 = 0
let maxAttempts2 = 100
var attempts2 = 0

gameLoop: while square2 < finalSquare2 {
    if attempts2 >= maxAttempts2 {
        print("Stuck in a loop or too many attempts - exiting.")
        break gameLoop
    }

    diceRoll2 += 1
    if diceRoll2 == 7 { diceRoll2 = 1 }
    square2 += diceRoll2
    if square2 < board2.count {
        square2 += board2[square2]
    }
    attempts2 += 1
}
print("Game over!")



// Early Exit

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")

}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])


// Deferring Actions

var score = 1
if score < 10 {
    defer {
        print(score)
    }
    score += 5
}
print(score) // 6 is printed first, then 6 is printed again.


// Checking API Availability

if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}