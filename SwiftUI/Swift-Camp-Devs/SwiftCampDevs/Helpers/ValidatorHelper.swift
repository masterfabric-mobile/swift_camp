import Foundation
import UIKit

enum ValidatorType {
    case username
    case password
    case email
    case search
    case phoneNumber
    case url
    case numeric
    case nonEmpty
    case name
    case surname
    case custom((String) -> String?)
}

struct ValidatorHelper {
    
    private let validatorType: ValidatorType
    
    init(type: ValidatorType) {
        self.validatorType = type
    }
    
    func validate(_ value: String) -> String? {
        let trimmedValue = StringHelper.shared.convertTurkishCharacters(
            StringHelper.shared.trim(value)
        )
        switch validatorType {
        case .username:
            return validateUsername(trimmedValue)
        case .password:
            return validatePassword(trimmedValue)
        case .email:
            return validateEmail(trimmedValue)
        case .search:
            return validateSearch(trimmedValue)
        case .phoneNumber:
            return validatePhoneNumber(trimmedValue)
        case .url:
            return validateURL(trimmedValue)
        case .numeric:
            return validateNumeric(trimmedValue)
        case .nonEmpty:
            return validateNonEmpty(trimmedValue)
        case .name:
            return validateName(trimmedValue)
        case .surname:
            return validateSurname(trimmedValue)
        case .custom(let customValidator):
            return customValidator(trimmedValue)
        }
    }
    
    // MARK: - Validation Methods
    
    private func validateUsername(_ value: String) -> String? {
        if value.isEmpty {
            return "Username cannot be empty."
        }
        if value.count < 3 {
            return "Username must be at least 3 characters long."
        }
        if value.count > 20 {
            return "Username cannot exceed 20 characters."
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegexPattern.username.pattern)
        if !predicate.evaluate(with: value) {
            return "Username can only contain letters, numbers, and underscores. Spaces are not allowed."
        }
        return nil
    }
    
    private func validatePassword(_ value: String) -> String? {
        
        if value.hasPrefix(" ") || value.hasSuffix(" ") || value.contains(" ") {
            return "Password must not contain spaces "
        }
        
        
        if value.isEmpty {
            return "Password cannot be empty."
        }
        
        // Validating the password
        if !NSPredicate(format: "SELF MATCHES %@", RegexPattern.password.pattern).evaluate(with: value) {
            return "Password must be 8-64 characters with uppercase, lowercase, a digit, and a special character."
        }
        
        return nil
    }
    
    private func validateEmail(_ value: String) -> String? {
        if value.isEmpty {
            return "Email cannot be empty."
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegexPattern.email.pattern)
        if !predicate.evaluate(with: value) {
            return "Invalid email format. Example: user@example.com"
        }
        return nil
    }
    
    private func validateName(_ value: String) -> String? {
        if value.isEmpty {
            return "Name cannot be empty."
        }
        if value.count < 2 {
            return "Name must be at least 2 characters long."
        }
        if value.count > 50 {
            return "Name cannot exceed 50 characters."
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegexPattern.name.pattern)
        if !predicate.evaluate(with: value) {
            return "Name can only contain letters and spaces."
        }
        return nil
    }
    
    private func validateSurname(_ value: String) -> String? {
        if value.isEmpty {
            return "Surname cannot be empty."
        }
        if value.count < 2 {
            return "Surname must be at least 2 characters long."
        }
        if value.count > 50 {
            return "Surname cannot exceed 50 characters."
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegexPattern.name.pattern)
        if !predicate.evaluate(with: value) {
            return "Surname can only contain letters and spaces."
        }
        return nil
    }
    
    private func validateSearch(_ value: String) -> String? {
        if value.isEmpty {
            return "Search input cannot be empty."
        }
        if value.count < 2 {
            return "Search input must be at least 2 characters."
        }
        if value.count > 50 {
            return "Search input cannot exceed 50 characters."
        }
        if value.contains(where: { !$0.isLetter && !$0.isNumber && !$0.isWhitespace }) {
            return "Search input can only contain letters, numbers, and spaces."
        }
        return nil
    }
    
    private func validatePhoneNumber(_ value: String) -> String? {
        if value.isEmpty {
            return "Phone number cannot be empty."
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegexPattern.phone.pattern)
        if !predicate.evaluate(with: value) {
            return "Invalid phone number format. Use international format (e.g., +123456789)."
        }
        if value.count < 8 {
            return "Phone number is too short. It must have at least 8 digits."
        }
        if value.count > 15 {
            return "Phone number is too long. It cannot exceed 15 digits."
        }
        return nil
    }
    
    private func validateURL(_ value: String) -> String? {
        if value.isEmpty {
            return "URL cannot be empty."
        }
        guard let url = URL(string: value), UIApplication.shared.canOpenURL(url) else {
            return "Invalid URL format. Example: https://www.example.com"
        }
        return nil
    }
    
    private func validateNumeric(_ value: String) -> String? {
        if value.isEmpty {
            return "Value cannot be empty."
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", RegexPattern.numeric.pattern)
        if !predicate.evaluate(with: value) {
            return "Value must be numeric. Example: 123 or 123.45"
        }
        return nil
    }
    
    private func validateNonEmpty(_ value: String) -> String? {
        if value.isEmpty {
            return "This field cannot be empty."
        }
        return nil
    }
}
