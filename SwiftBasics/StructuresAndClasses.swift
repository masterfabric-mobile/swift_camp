func runStructuresAndClassesExamples() {
    // ==================================================
    // DEFINITION SYNTAX
    // ==================================================
    struct Resolution {
        var width = 0
        var height = 0
    }
    class VideoMode {
        var resolution = Resolution()
        var frameRate = 0.0
        var name: String?
    }

    // ==================================================
    // STRUCTURE AND CLASS INSTANCES
    // ==================================================
    let someResolution = Resolution()
    let someVideoMode = VideoMode()

    // Printing initial values of properties
    print("Resolution width: \(someResolution.width)")
    print("VideoMode frame rate: \(someVideoMode.frameRate)")

    // ==================================================
    // ACCESSING PROPERTIES
    // ==================================================
    // Updating properties of a class instance
    someVideoMode.resolution.width = 1920
    someVideoMode.frameRate = 60.0
    someVideoMode.name = "1080p"

    // Printing updated property values
    print("Updated Resolution width: \(someVideoMode.resolution.width)")
    print("Updated Frame Rate: \(someVideoMode.frameRate)")
    print("Video Mode Name: \(someVideoMode.name ?? "Unknown")")

    // ==================================================
    // MEMBERWISE INITIALIZERS FOR STRUCTURE TYPES
    // ==================================================
    // Using a memberwise initializer for a structure
    let vgaResolution = Resolution(width: 640, height: 480)
    print("VGA Resolution: \(vgaResolution.width)x\(vgaResolution.height)")

    // ==================================================
    // STRUCTURES AND ENUMERATIONS ARE VALUE TYPES
    // ==================================================
    // Demonstrating value type behavior in structures
    let hdResolution = Resolution(width: 1920, height: 1080)
    var cinemaResolution = hdResolution
    cinemaResolution.width = 2048

    // Showing that the original structure remains unchanged
    print("HD Resolution width: \(hdResolution.width)") // Unchanged
    print("Cinema Resolution width: \(cinemaResolution.width)") // New value

    // ==================================================
    // CLASSES ARE REFERENCE TYPES
    // ==================================================
    // Demonstrating reference type behavior in classes
    let tenEighty = VideoMode()
    tenEighty.resolution = hdResolution
    tenEighty.frameRate = 30.0
    let alsoTenEighty = tenEighty // Points to the same reference

    alsoTenEighty.frameRate = 60.0
    // Showing that both variables refer to the same instance
    print("Frame Rate after update: \(tenEighty.frameRate)") // 60.0

    // ==================================================
    // IDENTITY OPERATORS
    // ==================================================
    // Using identity operators to compare class instances
    if tenEighty === alsoTenEighty { // === compares references
        print("tenEighty and alsoTenEighty refer to the same instance.")
    }
    if tenEighty !== someVideoMode { // !== compares different references
        print("tenEighty and someVideoMode refer to different instances.")
    }

    // ==================================================
    // POINTERS
    // ==================================================
    // Demonstrating the use of pointers in Swift (rarely needed)

    let a = 42
    withUnsafePointer(to: a) { pointer in
        print("Pointer Address: \(pointer)") // Shows the memory address
    }

    var mutableValue = 42
    withUnsafeMutablePointer(to: &mutableValue) { pointer in
        pointer.pointee += 1 // Modify value through pointer
        print("Updated Value: \(pointer.pointee)")
    }


    // Self
    struct Counter{
        var count = 0
        mutating func increase(){
            self.count += 1 //count of the Struct is called
        }
    }

    var theCounter Counter()
    theCounter.increase()
    print("Count is \(theCounter.count)") //Output: 1

}