//Closures
//It is an independent block of code. It can be assigned to a varible, passed as a parameter to anathor func, and returned from a func.

let sayHello = {
    print("Hello!")
}

/*syntax
{(parameters) -> return type in
    //code
}
*/
let greet: (String) -> String = { (name) -> String in
    return "Hello, \(name)!"
}
print(greet("Busra"))  // Hello, Busra!

//Closures as Parameters and Return Types
let greet2: (String) -> String = { name in
    "Hello, \(name)!"
}
print(greet2("World"))  // Hello, Busra!

//Trailing Closures
/*When the last parameter of a function is a closure, you can use the trailing closure syntax.
This moves the closure outside the parentheses.*/
func performAction(action: () -> Void) {
    action()
}

performAction {
    print("This is a trailing closure.")
}

//Autoclosures
//Automatically creates a closure. It makes your code more readable.
func printIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True!")
    }
}

printIfTrue(5 > 3)  // true!

//Capturing Values
//Closures can capture values from their surrounding scope.
func makeIncremater() -> () -> Int {
    var total = 0
    return {
        total += 1
        return total
    }

    let increment = makeIncremater()
    print(increment())  // 1
    print(increment())  // 2

}

//High-Order Functions with Closures
//map,filer,reduce functions are high-order functions. They take a closure as a parameter.
let numbers = [1, 2, 3, 4, 5]
let squaredNumbers = numbers.map { $0 * $0 }
print(squaredNumbers)  // [1, 4, 9, 16, 25]

//Escaping Closures
//some closures can extend outside of a function and be executed later. @escaping is used for this.
var completionHandlers: [() -> Void] = []
func addCompletionHandler(handler: @escaping () -> Void) {
    completionHandlers.append(handler)
}

addCompletionHandler {
print("Escaping closure.")
}

completionHandlers.forEach { $0() }