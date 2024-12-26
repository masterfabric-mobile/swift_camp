//The Basics
// Constants and Variables
let name = "Busra" // constant. It can not be changed.
var age = 25 // variable. It can be changed.

age = 22 // age is changed to 26 because it is a variable.
//name = "Ahmet" // error because name is a constant.
//Use constants as much as possible. Because it is safer.

// Data Types
let city: String = "Istanbul" // String
let population: Int = 15000000 // Integer
let temperature: Double = 25.5 // Double
let isRaining: Bool = false // Boolean

//no need to specify the type. Swift can infer the type. But Swift can say 'I can infer the type but write the type correctly.'

// Type Conversion
let intNumber = 5
let doubleNumber = 5.76
let sum = Double(intNumber) + doubleNumber // intNumber is converted to Double
print("Sum: \(sum)") //Swift says have rules so everything should be clear.

// Function print 
print("Name: \(name), Age: \(age)") 

// Comments Line
// This is a comment line
/* for multi line comments */

//Semicolons
let name1 = "Busra"; print(name1) // Swift does not require semicolons but you can use them this.