import Foundation

// 1. Stored Properties
struct User {
    var name: String
    var age: Int
}

// 2. Computed Properties
struct Account {
    var balance: Double

    var isOverdrawn: Bool {
        return balance < 0
    }
}

// 3. Property Observers
class Transaction {
    var amount: Double
    var date: Date {
        didSet {
            print("Transaction date updated to \(date)")
        }
    }

    init(amount: Double, date: Date) {
        self.amount = amount
        self.date = date
    }
}

// 4. Lazy Properties
class DatabaseManager {
    lazy var databaseConnection: String = {
        print("Establishing connection to the database...")
        return "Database Connection Established"
    }()

    func connect() -> String {
        return databaseConnection
    }
}

// 5. Read-Only Computed Property
struct Temperature {
    var celsius: Double

    var fahrenheit: Double {
        return (celsius * 9 / 5) + 32
    }
}

// 6. Property Wrapper
@propertyWrapper
struct Clamped<T: Comparable> {
    private var value: T
    let range: ClosedRange<T>

    init(wrappedValue: T, range: ClosedRange<T>) {
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
        self.range = range
    }

    var wrappedValue: T {
        get { return value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
}

struct BankUser {
    var name: String
    @Clamped(wrappedValue: 18, range: 18...100) var age: Int
}

// 7. Private Properties
class BankAccount {
    private var balance: Double

    init(balance: Double) {
        self.balance = balance
    }

    func deposit(amount: Double) {
        balance += amount
        print("Deposited \(amount), new balance is \(balance)")
    }

    func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
            print("Withdrew \(amount), new balance is \(balance)")
        } else {
            print("Insufficient funds!")
        }
    }

    var currentBalance: Double {
        return balance
    }
}

// Example Usage
let user = User(name: "Alice", age: 30)
print("User: \(user.name), Age: \(user.age)")

var account = Account(balance: 1000)
print("Account balance: \(account.balance), Is overdrawn: \(account.isOverdrawn)")

let transaction = Transaction(amount: 200, date: Date())
transaction.date = Date().addingTimeInterval(3600)

let dbManager = DatabaseManager()
print("Connection Status: \(dbManager.connect())")

let temp = Temperature(celsius: 25)
print("Temperature in Fahrenheit: \(temp.fahrenheit)")

var bankUser = BankUser(name: "Bob")
bankUser.age = 25
print("Bank User: \(bankUser.name), Age: \(bankUser.age)")
bankUser.age = 15
print("Updated Bank User Age: \(bankUser.age)")

let bankAccount = BankAccount(balance: 1000)
bankAccount.deposit(amount: 500)
bankAccount.withdraw(amount: 200)
print("Current Balance: \(bankAccount.currentBalance)")
