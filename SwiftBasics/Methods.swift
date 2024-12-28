import Foundation

// Instance Method
class Calculator {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}

// Static Method
class MathUtils {
    static func square(_ number: Int) -> Int {
        return number * number
    }
}

// Mutating Method
struct Counter {
    var count = 0
    
    mutating func increment() {
        count += 1
    }
}

// Initializer ile Kullanım
struct Rectangle {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
}

// Method Overloading
class Printer {
    func printMessage(_ message: String) {
        print("Mesaj: \(message)")
    }
    
    func printMessage(_ message: String, times: Int) {
        for _ in 0..<times {
            print("Mesaj: \(message)")
        }
    }
}

// Private Method
class BankAccount {
    private var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
        print("Yatırılan miktar: \(amount)")
    }
    
    private func displayBalance() {
        print("Bakiyeniz: \(balance)")
    }
}

// Recursive Method
func factorial(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }
    return n * factorial(n - 1)
}

// Kullanım Örnekleri
let calculator = Calculator()
print("Toplam: \(calculator.add(5, 3))")

print("Karesi: \(MathUtils.square(4))")

var counter = Counter()
counter.increment()
print("Sayaç: \(counter.count)")

let rectangle = Rectangle(width: 5.0, height: 3.0)
print("Alan: \(rectangle.area())")

let printer = Printer()
printer.printMessage("Merhaba")
printer.printMessage("Swift", times: 3)

let account = BankAccount()
account.deposit(amount: 100.0)
// account.displayBalance() // Private olduğundan çağrılamaz.

print("5 Faktöriyel: \(factorial(5))")