// MARK: - Basic Enums
/// Represents different types of weather conditions
enum Weather {
    case sunny
    case rainy
    case cloudy
    case snowy
    case windy
}

// MARK: - Enums with Raw Values
/// Represents days of the week with their corresponding integer values
enum DayOfWeek: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    /// Returns whether the day is a weekend or not
    var isWeekend: Bool {
        return self == .saturday || self == .sunday
    }
}

// MARK: - Enums with Associated Values
/// Represents different types of user notifications
enum Notification {
    case email(String, subject: String)
    case pushNotification(title: String, body: String)
    case sms(phoneNumber: String, message: String)
    
    /// Returns a formatted string representation of the notification
    func format() -> String {
        switch self {
        case .email(let address, subject: let subject):
            return "Email to: \(address), Subject: \(subject)"
        case .pushNotification(title: let title, body: let body):
            return "Push: \(title) - \(body)"
        case .sms(phoneNumber: let number, message: let message):
            return "SMS to: \(number), Message: \(message)"
        }
    }
}

// MARK: - Enums with Methods and Properties
/// Represents different payment methods with associated functionality
enum PaymentMethod {
    case cash(amount: Double)
    case creditCard(number: String, expiryDate: String, cvv: String)
    case digitalWallet(provider: String, accountId: String)
    
    /// Computed property that returns a user-friendly description
    var description: String {
        switch self {
        case .cash(let amount):
            return "Cash payment of $\(amount)"
        case .creditCard(let number, let expiry, _):
            let maskedNumber = "****" + number.suffix(4)
            return "Credit card \(maskedNumber), expires \(expiry)"
        case .digitalWallet(let provider, _):
            return "\(provider) digital wallet"
        }
    }
    
    /// Method to validate the payment method
    func validate() -> Bool {
        switch self {
        case .cash(let amount):
            return amount > 0
        case .creditCard(let number, let expiry, let cvv):
            return !number.isEmpty && !expiry.isEmpty && cvv.count == 3
        case .digitalWallet(_, let accountId):
            return !accountId.isEmpty
        }
    }
}

// MARK: - Testing Examples
func testEnums() {
    // Testing Weather enum
    let currentWeather = Weather.sunny
    switch currentWeather {
    case .sunny:
        print("It's a sunny day!")
    case .rainy:
        print("Don't forget your umbrella!")
    case .cloudy:
        print("It's cloudy today")
    case .snowy:
        print("Winter is here!")
    case .windy:
        print("Hold onto your hat!")
    }
    
    // Testing DayOfWeek enum
    let today = DayOfWeek.wednesday
    print("Day number: \(today.rawValue)")
    print("Is it weekend? \(today.isWeekend)")
    
    // Testing Notification enum
    let notification = Notification.email("user@example.com", subject: "Hello!")
    print(notification.format())
    
    // Testing PaymentMethod enum
    let payment = PaymentMethod.creditCard(number: "1234567890123456", 
                                         expiryDate: "12/24", 
                                         cvv: "123")
    print(payment.description)
    print("Payment is valid: \(payment.validate())")
}

// Run tests
testEnums()