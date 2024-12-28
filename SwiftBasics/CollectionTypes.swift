

//array
//Creating an array and usage of array literal
var fruits: [String] = ["Apple", "Banana", "Cherry"]
fruits.append("Orange") //appending an element to an array.
print(fruits)

var vegetables: [String] = ["Tomato","Potato"]
//concatenation of two array
var foods   = fruits+vegetables  //Also += operator can be used here aswell
print(foods)

//accessing to the array
print("The list contains \(vegetables.count) items.")

//reaching the last element of the array
let lastElement = foods [-1]

//changing elements with another
foods[2...3]=["Pineapple","Strawberry"]
print(foods)

//inserting element to a spesific position
foods.insert("Kiwi", at: 2)
print(foods)

//removing tke Kiwi from the array
foods.remove(at: 2)
print(foods)

//iterating over an array
for item in foods {
    print(item)
}

//Creating an array with a default Value
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

//set

//empty set
var letters = Set<Character>()

// Creating a set with an array  and adding items
var uniqueNumbers: Set<Int> = [1, 2, 3, 1, 2]
print(uniqueNumbers) // {3, 2, 1}
uniqueNumbers.insert(4)
// Accessing a set
print(uniqueNumbers) // {3, 2, 1, 4}
print(uniqueNumbers.count)

// Inserting new element
uniqueNumbers.insert(5)
print(uniqueNumbers)

// Remove an element and assigning into a variable
if let removed: Int = uniqueNumbers.remove(2){
    print("\(removed) found.")
}else{
    print("could not found that element.")
}

// Checking if an element exists
if uniqueNumbers.contains(2) {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

// Iterating over a Set
for num in uniqueNumbers {
    print("\(num)")
}

// Fundamental Set Operations
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]


print(oddDigits.union(evenDigits).sorted())
// expected value [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(oddDigits.intersection(evenDigits).sorted())
// expected value []
print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
// expected value [1, 9]
print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())
// expected value [1, 2, 9]



//dictionary


// Key value relation of dictionary.
var studentScores: [String: Int] = ["Alice": 85, "Bob": 90]
studentScores["Charlie"] = 88
print(studentScores) // ["Alice": 85, "Bob": 90, "Charlie": 88]

if studentScores.isEmpty {
    print("The studentScores dictionary is empty.")
} else {
    print("The studentScores dictionary isn't empty.")
}

// Adding a new element to the dictionary
studentScores["James"]=70

// Updating the existing value
studentScores["James"]=85

// Updating the existing value but saving the old value
if let oldValue = studentScores.updateValue(55, forKey:"James" ) {
    print("The old score of James was \(oldValue).")
}

//Iterating over a dictionary
for (name, score) in studentScores {
    print("\(name): \(score)")
}

