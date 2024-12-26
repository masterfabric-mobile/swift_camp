//Aritmetic Operators
let a = 10
let b = 3
print("Sum: \(a + b)") // 13
print("Subtraction: \(a - b)") // 7
print("Multiplication: \(a * b)") // 30
print("Division: \(a / b)") // 3
print("Remainder: \(a % b)") // 1

//Comparison Operators
let x = 5
let y = 10
print(x == y) // false
print(x != y) // true
print(x > y) // false
print(x < y) // true
print(x >= y) // false
print(x <= y) // true

//Logical Operators
let isSwiftFun = true
let isSwiftHard = false
print(isSwiftFun && isSwiftHard) // false because both of them should be true
print(isSwiftFun || isSwiftHard) // true because it is enough for one of these to be true
print(!isSwiftFun) // false because takes the opposite of isSwiftFun

//Assignment Operators
var score = 10
score += 5 // score = score + 5 = 15
score *= 2 // score = score * 2 = 30

//Combining Operators
let greeting = "Hello, "
let name = "Busra"
print(greeting + ", " + name) // Hello, Busra

//Precedence and Use of Parentheses
let result = 10 + 2 * 5 // 10 + (2 * 5) = 20
let correctResult = (10 + 2) * 5 // (10 + 2) * 5 = 60
print(result)
print(correctResult)


