// Protocol can be defined a following way.

protocol Animal {
  
    var age: Int {get}
    var kind: String {get}
    var gender: String {get}
    func makeNoise() -> String
    var isHungry: Bool {get} 
    var isInfertile: Bool {get}

}

protocol DomesticAnimal: Animal {
    
    var name: String {get}
    var vaccineSchedule: String {get}
    var chipNumber: Int {get}
    var isWalkPublic: Bool {get}
    func feed() -> String
    
}
//BreedingManager class can be used encapsulate to breed logics. This allows to centralize the management plus modificate to easily if needed.

class BreedingManager{
    func numberOfBabies(animal1:Animal, animal2: Animal) -> Int{ 
        
        var babies: Int = Int.random(in: 1..<5)

        if(animal1.kind == animal2.kind && !(animal1.isInfertile && animal2.isInfertile)) {
            print("these animals can be mated and they can be has babies")
            return babies
        }

        babies = 0

        return  babies
    }
}
// Class can get inheritance from protocol
class Cat: DomesticAnimal {
    var isWalkPublic: Bool
    var breeding: BreedingManager
    var isInfertile: Bool
    var isHungry: Bool
    var name: String
    var vaccineSchedule: String
    var chipNumber: Int

    func feed() -> String {
        if(isHungry) {
            let hungryCat: String = "The food bowl fulled with Whiskas"
            return hungryCat
        }
        let fullCat: String = "There is still some food in bowl."
        return fullCat
    }

    var age: Int
    var kind: String
    var gender: String

    func makeNoise() -> String {
        if(isHungry) {
            return "miiyav miiiyav"
        }
        return "mirmirrr"
    }

    init(name: String, vaccineSchedule: String, chipNumber: Int, age: Int, kind: String, gender: String, isHungry: Bool, isInfertile: Bool, breeding: BreedingManager, isWalkPublic: Bool) {
   
    self.name = name
    self.vaccineSchedule = vaccineSchedule
    self.chipNumber = chipNumber
    self.age = age
    self.kind = kind
    self.gender = gender
    self.isHungry = isHungry
    self.isInfertile = isInfertile
    self.breeding = breeding
    self.isWalkPublic = isWalkPublic
    }
}

//extensions can be written on protocol.

extension DomesticAnimal {
    
    func wearingMuzzle() -> String{
        return isWalkPublic ? "While taking a ride in public must wear muzzle" : "No need to wear muzzle at home"

    }

}

class Lion: Animal {

    var age: Int
    var kind: String
    var gender: String
    func makeNoise() -> String {
     if(isHungry) {
        return "RRrrrRrRrrRRRR"
     } 
        return ""  
    }

    var isHungry: Bool
    var isInfertile: Bool

internal init(age: Int, kind: String, gender: String, isHungry: Bool, isInfertile: Bool) {
   
    self.age = age
    self.kind = kind
    self.gender = gender
    self.isHungry = isHungry
    self.isInfertile = isInfertile
    
    }

}

let breedingManager: BreedingManager = BreedingManager()


let catOne : Cat = Cat(name: "osman", vaccineSchedule: "Completed.", chipNumber: 1111, age: 3, kind: "british", gender: "male", isHungry: true, isInfertile: false, breeding: breedingManager, isWalkPublic: true)
let catTwo : Cat = Cat(name: "keltos", vaccineSchedule: "Completed", chipNumber: 1112, age: 2, kind: "british", gender: "female", isHungry: false, isInfertile: false, breeding: breedingManager, isWalkPublic: false)

let lionOne: Lion = Lion(age: 3, kind: "lion", gender: "male", isHungry: true, isInfertile: true)
let lionTwo: Lion = Lion(age: 4, kind: "lion", gender: "male", isHungry: false, isInfertile: true)

let catBabies: Int = breedingManager.numberOfBabies(animal1: catOne, animal2: catTwo)

let lionBabies: Int = breedingManager.numberOfBabies(animal1: lionOne, animal2: lionTwo)

let forbiddenBabies: Int = breedingManager.numberOfBabies(animal1: catOne, animal2: lionTwo)

print("First cat is \(catOne.name), second cat is \(catTwo.name), first lion is \(lionOne), second lion is \(lionTwo), the number of babies that cats have \(catBabies), the number of babies that lions have \(lionBabies), the unexpected babies that cat and lion have \(forbiddenBabies)")

let walkingCat: String = catOne.wearingMuzzle()
let homeCat: String = catTwo.wearingMuzzle()

print("\(walkingCat) \n \(homeCat)")
