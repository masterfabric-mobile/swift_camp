// The Basics

// Constants and Variables
let name = "Busra" // constant. It can not be changed.
var age = 25 // variable. It can be changed.

age = 22 // age is changed to 22 because it is a variable.
//name = "Ahmet" // error because name is a constant.
// Use constants as much as possible. Because it is safer.

let birthYear = 1998 // Constant birth year. It won't change
let currentYear = 2024
let yearsLived = currentYear - birthYear // Calculate the years lived
print("Years lived: \(yearsLived)") // Output the number of years lived

// Data Types
let city: String = "Istanbul" // String
let population: Int = 15000000 // Integer
let temperature: Double = 25.5 // Double
let isRaining: Bool = false // Boolean

// Swift infers types automatically, but specifying is good for clarity
let country = "Turkey" // Swift infers this as a String

// String Interpolation and Concatenation
let greeting = "Hello, my name is \(name) and I live in \(city)."
print(greeting) // Output: Hello, my name is Busra and I live in Istanbul.

let fullDescription = "The population of \(city) is \(population) and the current temperature is \(temperature)°C."
print(fullDescription) // Output: The population of Istanbul is 15000000 and the current temperature is 25.5°C.

// Type Conversion
let intNumber = 5
let doubleNumber = 5.76
let sum = Double(intNumber) + doubleNumber // intNumber is converted to Double
print("Sum: \(sum)") // Output: Sum: 10.76

// Multiplying two Doubles
let areaOfCircle = Double(intNumber) * 3.14 // Circle area approximation
print("Area of circle: \(areaOfCircle)") // Output: Area of circle: 15.7

// Function print
print("Name: \(name), Age: \(age), City: \(city), Country: \(country)") 

// Comments
// This is a comment line explaining a part of the code
/* This is a 
multi-line comment used for longer explanations */

// Semicolons
let name1 = "Busra"; print(name1) // Swift does not require semicolons but you can use them here.

// Arrays and Loops
let favoriteColors = ["Blue", "Green", "Red", "Yellow"] // Array of Strings
for color in favoriteColors {
    print("One of my favorite colors is \(color).") // Loop through each color and print it
}

// Dictionaries
let personInfo = ["name": "Busra", "age": "22", "city": "Istanbul"]
if let personName = personInfo["name"] {
    print("Person's name is \(personName).") // Output: Person's name is Busra.
}

// Conditional Statements
if isRaining {
    print("It's raining. Don't forget your umbrella!") // This will not print since isRaining is false
} else {
    print("It's not raining. You can go outside without an umbrella.") // This will print
}

// Optional Variables
var middleName: String? = "Aylin" // Optional String, it can be nil
if let unwrappedMiddleName = middleName {
    print("Middle name is \(unwrappedMiddleName).") // Unwrap and print the value if it's not nil
} else {
    print("No middle name provided.") // If the value is nil
}
