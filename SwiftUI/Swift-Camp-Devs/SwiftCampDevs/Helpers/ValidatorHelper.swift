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
    case fullName
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
        
        var errorMessages: [String] = []
        
        // Perform validation checks
        switch validatorType {
        case .username:
            errorMessages += validateTextField(value: trimmedValue, type: .username)
        case .password:
            errorMessages += validateTextField(value: trimmedValue, type: .password)
        case .email:
            errorMessages += validateTextField(value: trimmedValue, type: .email)
        case .search:
            errorMessages += validateTextField(value: value, type: .search)
        case .phoneNumber:
            errorMessages += validateTextField(value: trimmedValue, type: .phoneNumber)
        case .url:
            errorMessages += validateTextField(value: trimmedValue, type: .url)
        case .numeric:
            errorMessages += validateTextField(value: trimmedValue, type: .numeric)
        case .nonEmpty:
            errorMessages += validateTextField(value: trimmedValue, type: .nonEmpty)
        case .fullName:
            errorMessages += validateTextField(value: trimmedValue, type: .fullName)
        case .custom:
            errorMessages += validateTextField(value: trimmedValue, type: .custom(placeholder: "Enter custom input", keyboardType: .asciiCapable))
        }
        
        return errorMessages.isEmpty ? nil : errorMessages.joined(separator: "\n")
    }
    
    private func validateTextField(value: String, type: TextFieldType) -> [String] {
        var errors: [String] = []
        // Checking Minimum Length
        if let min = type.minLength, value.count < min {
            errors.append("\(type.displayName) must be at least \(min) characters long.")
        }
        
        // Checking Maximum Length
        if let max = type.maxLength, value.count > max {
            errors.append("\(type.displayName) cannot exceed \(max) characters.")
        }
        
        // Regex Validation
        switch type {
        case .username:
            if let error = validateUsername(value) { errors.append(error) }
        case .password:
            if let error = validatePassword(value) { errors.append(error) }
        case .email:
            if let error = validateEmail(value) { errors.append(error) }
        case .search:
            if let error = validateSearch(value) { errors.append(error) }
        case .phoneNumber:
            if let error = validatePhoneNumber(value) { errors.append(error) }
        case .url:
            if let error = validateURL(value) { errors.append(error) }
        case .numeric:
            if let error = validateNumeric(value) { errors.append(error) }
        case .nonEmpty:
            if let error = validateNonEmpty(value) { errors.append(error) }
        case .fullName:
            if let error = validateFullName(value) { errors.append(error) }
        case .custom(_, _):
            if let error = validateCustom(value) { errors.append(error) }
        }
        
        return errors
    }
    
    // MARK: - Validation Methods    
    private func validateUsername(_ value: String) -> String? {

        if !RegexPattern.username.matches(value) {
                return RegexPattern.username.description
            }
            return nil
    }
    
    private func validatePassword(_ value: String) -> String? {
        
        if value.hasPrefix(" ") || value.hasSuffix(" ") || value.contains(" ") {
            return "Password must not contain spaces "
        }
        
        if !RegexPattern.password.matches(value) {
            return RegexPattern.password.description
        }
        return nil
    }
    
    private func validateEmail(_ value: String) -> String? {
        
        if !RegexPattern.email.matches(value) {
            return RegexPattern.email.description
        }
        return nil
    }
    
    private func validateFullName(_ value: String) -> String? {
        
        if(value.contains("  ")){
            return "Full name must not contain consecutive spaces."
        }
        if !RegexPattern.fullName.matches(value) {
            return RegexPattern.fullName.description
        }
        return nil
    }
    
    private func validateSearch(_ value: String) -> String? {
        return nil
    }
    
    private func validatePhoneNumber(_ value: String) -> String? {
        
        if !RegexPattern.phone.matches(value) {
            return RegexPattern.phone.description
        }
        return nil
    }
    
    private func validateURL(_ value: String) -> String? {
        
        if !RegexPattern.url.matches(value) {
            return RegexPattern.url.description
        }
        return nil
    }
    
    private func validateNumeric(_ value: String) -> String? {
        
        if !RegexPattern.numeric.matches(value) {
            return RegexPattern.numeric.description
        }
        return nil
    }
    
    private func validateNonEmpty(_ value: String) -> String? {
        if value.isEmpty {
            return "This field cannot be empty."
        }
        return nil
    }
    
    private func validateCustom(_ value: String) -> String? {
        if value.isEmpty {
            return "This field cannot be empty."
        }
        return nil
    }
}
