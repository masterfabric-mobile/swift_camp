//Initialization
// Stored properties must be initialized to ensure they have valid values before use. This can be done when defining the property or within an initializer.
struct Person {
    var name: String
    var age: Int = 18
}

let person = Person(name: "John")
print(person.name)  // John
print(person.age)  // 18

//İnitializers are special func in classes, structeres, or enums to set up initial values for properties.
struct  Rectangle {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

let rectangle = Rectangle(width: 10.0, height: 20.0)
print("Width: \(rectangle.width), Height: \(rectangle.height)")  // Width: 10.0, Height: 20.0

//Default initializers are provided automatically if all properties have default values.
struct Circle {
    var radius = 1.0
}

let circle = Circle()
print(circle.radius)  // 1.0

//Failabel Initializers
//An initializer can return nil to indicate that initialization has failed.
struct Temperature {
    var celsius: Double

    init?(celsius: Double) {
        if celsius < -273.15 {
            return nil //Below absolute zero, fail the initialization
        }
       self.celsius = celsius
    }
}

if let validTemp = Temperature(celsius: -200) {
    print(validTemp) // Temperature(celsius: -200.0)
} else {
    print("Temperature is invalid") // Temperature is invalid
}

//Initializer Delegation
//One initializer can call another initializer. This reduces code duplication.
struct Rectangle2 {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    init(squareSide: Double) {
        self.init(width: squareSide, height: squareSide) //Delegate to the other initializer
    }
}

let square = Rectangle2(squareSide: 5)
print(square) // Rectangle2(width: 5.0, height: 5.0)

//Required Initializers
//A class can enforce its subclasses to implement an initializer by marking ,t w,th the required keyword.
class Animal {
    var name: String

    required init(name: String) {
        self.name = name
    }
}

class Dog: Animal {
    required init(name: String) {
        super.init(name: name)
    }
}

let dog = Dog(name: "Bobby")
print(dog.name)  // Bobby

//Convenience Initializers
//Convenience initializers are secondary, supporting initializers that call the designated initializer.
class Vehicle {
    var type: String
    var wheels: Int

    init(type: String, wheels: Int) {
        self.type = type
        self.wheels = wheels
    }

    convenience init() {
        self.init(type: "Car", wheels: 4) //Delegate to the designated initializer
    }
}

let defaultVehicle = Vehicle()
print(defaultVehicle) // Vehicle(type: "Car", wheels: 4)