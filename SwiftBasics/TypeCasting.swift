class Animal {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class Dog: Animal {
    func bark() {
        print("Woof!")
    }
}

class Cat: Animal {
    func meow() {
        print("Meow!")
    }
}

// Using is Operator
let animal1 = Animal(name: "Generic Animal") 
let animal2 = Dog(name: "Fido")             

if animal1 is Dog {          // Check if animal1 is an instance of Dog class
    print("animal1 is a Dog") 
} else {
    print("animal1 is not a Dog") 
}

if animal2 is Dog {             // Check if animal2 is an instance of Dog class
    print("animal2 is a Dog")
} else {
    print("animal2 is not a Dog")
}
// Outout:
// animal1 is not a Dog
// animal2 is a Dog

let animal3: Animal = Dog(name: "Buddy")

if let dog = animal3 as? Dog { // Attempt to downcast animal3 to Dog type. 
    dog.bark()
} else {
    print("animal3 is not a Dog")
}
// Output: Woof!

let animals: [Animal] = [Animal(name: "Generic Animal"), Dog(name: "Fido"), Cat(name: "Whiskers")]

for animal in animals {
    if let dog = animal as? Dog {// Attempt to downcast the current 'animal' to a Dog.
    } else if let cat = animal as? Cat {// Attempt to downcast the current 'animal' to a Cat.
        cat.meow()
    } else {
        print("Unknown animal")
    }
}
// Output:
// Unknown animal
// Woof!
// Meow!


// Any and AnyObject
let anyArray: [Any] = ["Hello", 13, 5.1, true]

for item in anyArray{ // Output: String Int Double true
    if let string = item as? String {
        print("String: \(string)")
    } else if let int = item as? Int {
        print("Int: \(int)")
    } else if let double = item as? Double {
        print("Double: \(double)")
    } else {
        print("Other type: \(item)")
    } 
}

// Typealias
typealias Coordinate = (x: Int, y: Int, z: Int)
let thePoint: Coordinate = (x: 5, y: 10, z: 20)
print("The point is at (\(thePoint.x), \(thePoint.y), \(thePoint.z))") // Output: The point is at (5, 10, 20)