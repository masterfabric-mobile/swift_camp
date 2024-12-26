// Inheritance
// Inheritance is a mechanism that allows a class to inherit properties, methods, and other features from another class.
// Subclass can access all the properties and methods of a superclass.
// Properties and methods of the superclass can be overridden in the subclass.

// Base Class
class Vehicle {
    var currentSpeed: Double
    var description: String {
        return "Traveling at \(currentSpeed) miles per hour"
    }

    init(currentSpeed: Double = 0.0) {
        self.currentSpeed = currentSpeed
    }

    func makeNoise() {
        // Base implementation
    }
}

// Subclass
class Bicycle: Vehicle {
    var hasBasket: Bool

    init(currentSpeed: Double = 0.0, hasBasket: Bool = false) {
        self.hasBasket = hasBasket
        super.init(currentSpeed: currentSpeed)
    }
}

class Tandem: Bicycle {
    var currentNumberOfPassengers: Int

    init(currentSpeed: Double = 0.0, hasBasket: Bool = false, currentNumberOfPassengers: Int = 0) {
        self.currentNumberOfPassengers = currentNumberOfPassengers
        super.init(currentSpeed: currentSpeed, hasBasket: hasBasket)
    }
}

// Overriding Example
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

// Subclass with Getter and Setter Overriding
class Car: Vehicle {
    var gear: Int

    override var description: String {
        return super.description + " in gear \(gear)"
    }

    init(currentSpeed: Double = 0.0, gear: Int = 1) {
        self.gear = gear
        super.init(currentSpeed: currentSpeed)
    }
}

// Property Observer Example
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

// Final Keyword Example
final class FinalClass {
    var speed: Double

    init(speed: Double = 0.0) {
        self.speed = speed
    }
}

// Testable Code: Helper Functions
func createTestVehicle() -> Vehicle {
    return Vehicle(currentSpeed: 10.0)
}

func createTestBicycle() -> Bicycle {
    return Bicycle(currentSpeed: 15.0, hasBasket: true)
}

func createTestCar() -> Car {
    return Car(currentSpeed: 25.0, gear: 3)
}

func createTestAutomaticCar() -> AutomaticCar {
    let car = AutomaticCar(currentSpeed: 35.0, gear: 1)
    car.currentSpeed = 45.0  // To trigger didSet
    return car
}

// Example Usage
let testVehicle = createTestVehicle()
print(testVehicle.description)  // Traveling at 10.0 miles per hour

let testBicycle = createTestBicycle()
print(testBicycle.description)  // Traveling at 15.0 miles per hour

let testCar = createTestCar()
print(testCar.description)  // Traveling at 25.0 miles per hour in gear 3

let testAutomaticCar = createTestAutomaticCar()
print(testAutomaticCar.description)  // Traveling at 45.0 miles per hour in gear 5