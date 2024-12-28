// Swift: Strings and Characters Summary

// String Literals
let greeting = "Hello, world!"

// Multiline String Literals
let multilineString = """
This is a
multiline string.
"""

// Special Characters in String Literals
let wiseWords: String = "He said, \"Swift is amazing!\""
let dollarSign = "\u{24}"        // $
let blackHeart = "\u{2665}"      // ♥
let sparklingHeart = "\u{1F496}" // 💖

// Extended String Delimiters
let rawString = #"Line 1\nLine 2"#

// Initializing an Empty String
var emptyString = ""
var anotherEmptyString = String()

// String Mutability
var variableString = "Hello"
variableString += ", world!" // "Hello, world!"

let constantString = "Hello"
// constantString += ", world!" // Error: constantString is immutable

// Strings Are Value Types

// Working with Characters
for character in "Dog!🐶" {
    print(character)
}

// Concatenating Strings and Characters
let string1 = "Hello"
let string2 = " there"
var welcome = string1 + string2 // "Hello there"
welcome += "!" // "Hello there!"

// String Interpolation
let name = "John"
let age = 30
let introduction = "My name is \(name) and I am \(age) years old."

// Counting Characters
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters.")

// Accessing and Modifying a String
let greeting2 = "Hello"
print(greeting2[greeting2.startIndex]) // H
print(greeting2[greeting2.index(before: greeting2.endIndex)]) // o
print(greeting2[greeting2.index(after: greeting2.startIndex)]) // e
let index = greeting2.index(greeting2.startIndex, offsetBy: 2)
print(greeting2[index]) // l

// Inserting and Removing
var welcome2 = "hello"
welcome2.insert("!", at: welcome2.endIndex) // "hello!"
welcome2.insert(contentsOf: " there", at: welcome2.index(before: welcome2.endIndex)) // "hello there!"
welcome2.remove(at: welcome2.index(before: welcome2.endIndex)) // "hello there"
let range = welcome2.index(welcome2.endIndex, offsetBy: -6)..<welcome2.endIndex
welcome2.removeSubrange(range) // "hello"

// Substrings
let greeting3 = "Hello, world!"
let index2 = greeting3.firstIndex(of: ",") ?? greeting3.endIndex
let beginning = greeting3[..<index2] // "Hello"
let newString = String(beginning) // Convert to String

// Comparing Strings
let quote = "To be, or not to be, that is the question."
print(quote.hasPrefix("To be")) // true
print(quote.hasSuffix("question.")) // true