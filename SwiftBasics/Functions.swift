//Functions

//Parameterless and Irreversible Functions
func sayHello() {
    print("Hello!")
}

sayHello()

//Multiple Parameters
func addNumbers(number1: Int, number2: Int) -> Int{
   return number1 + number2
}

let sum = addNumbers(number1: 5, number2: 2)
print(sum) // 7

//Default Parameters
func greetPerson(name: String = "Busra") {
    print("Hello, \(name)!")
}
greetPerson() // Hello, Busra
greetPerson(name: "Ali") // Hello, Ali

//In-Out Parameters
//Allows a variable to be changed within a function
func doubleNumber(number: inout Int) {
    number *= 2
}

var value = 10
doubleNumber(number: &value)
print(value) // 20

//Multiple Return Values
func calculateScores() -> (math: Int, science: Int) {
    return (95, 88)
}

let scores = calculateScores()
print("Math: \(scores.math), Science: \(scores.science)")

//Nested Functions
//Functions inside other functions
func makeMultiplier(multiplier: Int) -> (Int) -> Int {
    func multiply(number: Int) -> Int {
        return number * multiplier
    }
    return multiply
}

let triple = makeMultiplier(multiplier: 3)
print(triple(4)) // 12

//Higher Order Functions
//Functions that take other functions as parameters or return functions
func applyFunction(number: Int, operation: (Int) -> Int) -> Int {
    return operation(number)
}

let result = applyFunction(number: 5, operation: { $0 * $0 })
print("Result: \(result)") // Result: 25

// Function to divide two numbers, returns an optional Int
func divide(number1: Int, number2: Int) -> Int? {
    if number2 != 0 {
        return number1 / number2
    } else {
        return nil
    }
}

if let result = divide(number1: 10, number2: 2) {
    print("Result: \(result)")  // Result: 5
} else {
    print("Invalid operation!") // Division by zero is not allowed
}

// A function that takes a parameter 'name' with a default value of "Stranger"
func introduce(name: String = "Stranger") {
     print("Hi, \(name)!")
}
introduce() // Output: Hi, Stranger!
introduce(name: "Beyza") // Output: Hi, Beyza!