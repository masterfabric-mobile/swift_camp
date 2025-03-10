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
        case .custom(let customValidator):
                    if let error = customValidator(trimmedValue) {
                        errorMessages.append(error)
                    }
        }
        
        return errorMessages.isEmpty ? nil : errorMessages.joined(separator: "\n")
    }
    
    private func validateTextField(value: String, type: TextFieldType) -> [String] {
        var errors: [String] = []
        
        // Length Validation
        if let min = type.minLength, value.count < min {
            errors.append(Strings.Validator.minLengthError(field: type.displayName, min: min))
        }
        if let max = type.maxLength, value.count > max {
            errors.append(Strings.Validator.maxLengthError(field: type.displayName, max: max))
        }
        
        if let error = validateByType(value: value, type: type) {
            errors.append(error)
        }
        
        return errors
    }

    private func validateByType(value: String, type: TextFieldType) -> String? {
        switch type {
        case .username: return validateUsername(value)
        case .password: return validatePassword(value)
        case .email: return validateEmail(value)
        case .search: return validateSearch(value)
        case .phoneNumber: return validatePhoneNumber(value)
        case .url: return validateURL(value)
        case .numeric: return validateNumeric(value)
        case .nonEmpty: return validateNonEmpty(value)
        case .fullName: return validateFullName(value)
        case .custom(_, _): return validateCustom(value)
        }
    }
    
    // MARK: - Validation Methods
    private func validateUsername(_ value: String) -> String? {

        if !RegexPattern.username.matches(value) {
            return Strings.Validator.usernameInvalid
            }
            return nil
    }
    
    private func validatePassword(_ value: String) -> String? {
        
        if value.contains(" ") {
                   return Strings.Validator.passwordSpaces
               }
               if !RegexPattern.password.matches(value) {
                   return Strings.Validator.passwordInvalid
               }
        return nil
    }
    
    private func validateEmail(_ value: String) -> String? {
        
        if !RegexPattern.email.matches(value) {
            return Strings.Validator.emailInvalid
        }
        return nil
    }
    
    private func validateFullName(_ value: String) -> String? {
        
        if(value.contains("  ")){
            return Strings.Validator.fullNameConsecutiveSpaces
        }
        if !RegexPattern.fullName.matches(value) {
            return Strings.Validator.fullNameInvalid
        }
        return nil
    }
    
    private func validateSearch(_ value: String) -> String? {
        return nil
    }
    
    private func validatePhoneNumber(_ value: String) -> String? {
        
        if !RegexPattern.phone.matches(value) {
            return Strings.Validator.phoneNumberInvalid
        }
        return nil
    }
    
    private func validateURL(_ value: String) -> String? {
        
        if !RegexPattern.url.matches(value) {
            return Strings.Validator.urlInvalid
        }
        return nil
    }
    
    private func validateNumeric(_ value: String) -> String? {
        
        if !RegexPattern.numeric.matches(value) {
            return Strings.Validator.numericInvalid
        }
        return nil
    }
    
    private func validateNonEmpty(_ value: String) -> String? {
        if value.isEmpty {
            return Strings.Validator.fieldEmpty
    }
        return nil
    }
    
    private func validateCustom(_ value: String) -> String? {
        if value.isEmpty {
            return Strings.Validator.fieldEmpty
        }
        return nil
    }
}
