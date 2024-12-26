//Optional Chaning
//Optional chaining allows us to perform operations without receiving an error in case the value of an optional is "nil" when accessing it.
//If an optional value is present,the operations continue; if not, the transaction chain is enterrupted and nil is returned.
//While forced unwrapping(!) throws an error, optional chaining(?) returns nil.

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
    var address: Address?
}

let john = Person()

//Access with optional chaining
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
} //Output: Unable to retrieve the number of rooms.

//Multiple levels of optional chaining
//It can be used to securely access data at multiple depths.
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
}

let alice = Person()
alice.residence = Residence()

if let street = alice.residence?.address?.street {
    print("Street name is \(street).")
} else {
    print("Unable to retrieve the street name.")
} //Output: Unable to retrieve the street name.

/*Security: It is possible to proceed without errors while working with nil values.
Readability: The code becomes cleaner and more understandable.
Flexibility: It provides suitable solutions against the possibility of interruption at any point in the chain.
*/