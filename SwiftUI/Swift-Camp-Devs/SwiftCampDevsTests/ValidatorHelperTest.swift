import XCTest
@testable import SwiftCampDevs

final class ValidatorHelperTests: XCTestCase {

    // MARK: - Helper Functions
    private func validateAndExpectNoError(value: String, type: ValidatorType, file: StaticString = #file, line: UInt = #line) {
        LoggerHelper.shared.info("🛠 Validating '\(value)' for type \(type) - Expecting NO error")

        let validator = ValidatorHelper(type: type)
        let errorMessage = validator.validate(value)

        if let errorMessage {
            LoggerHelper.shared.error("❌ Unexpected error: \(errorMessage)")
        } else {
            LoggerHelper.shared.info("✅ Validation successful - No error as expected")
        }

        XCTAssertNil(errorMessage, "Expected no error but got: \(errorMessage ?? "nil")", file: file, line: line)
    }

    private func validateAndExpectError(value: String, type: ValidatorType, expectedMessage: String, file: StaticString = #file, line: UInt = #line) {
        LoggerHelper.shared.info("🛠 Validating '\(value)' for type \(type) - Expecting error containing: '\(expectedMessage)'")

        let validator = ValidatorHelper(type: type)
        let errorMessage = validator.validate(value)

        if let errorMessage {
            LoggerHelper.shared.warning("⚠️ Validation failed as expected: \(errorMessage)")
        } else {
            LoggerHelper.shared.error("❌ Expected error but validation passed unexpectedly")
        }

        XCTAssertNotNil(errorMessage, "Expected error message but got nil", file: file, line: line)
        XCTAssertTrue(errorMessage?.contains(expectedMessage) ?? false, "Expected error message to contain '\(expectedMessage)', but got: \(errorMessage ?? "nil")", file: file, line: line)
    }

    // MARK: - Tests

    func testValidateUsername_Valid() {
        validateAndExpectNoError(value: "valid_username123", type: .username)
    }

    func testValidateUsername_Invalid() {
        validateAndExpectError(
            value: "invalid username!",
            type: .username,
            expectedMessage: Strings.Validator.usernameInvalid
        )
    }

    func testValidatePassword_Valid() {
        validateAndExpectNoError(value: "StrongP@ssw0rd", type: .password)
    }

    func testValidatePassword_Invalid_Spaces() {
        validateAndExpectError(
            value: "Pass word",
            type: .password,
            expectedMessage: Strings.Validator.passwordSpaces
        )
    }

    func testValidateEmail_Valid() {
        validateAndExpectNoError(value: "test@example.com", type: .email)
    }

    func testValidateEmail_Invalid() {
        validateAndExpectError(
            value: "invalid-email",
            type: .email,
            expectedMessage: Strings.Validator.emailInvalid
        )
    }

    func testValidatePhoneNumber_Valid() {
        validateAndExpectNoError(value: "+905551234567", type: .phoneNumber)
    }

    func testValidatePhoneNumber_Invalid() {
        validateAndExpectError(
            value: "036673448",
            type: .phoneNumber,
            expectedMessage: Strings.Validator.phoneNumberInvalid
        )
    }

    func testValidateURL_Valid() {
        validateAndExpectNoError(value: "https://www.example.com", type: .url)
    }

    func testValidateURL_Invalid() {
        validateAndExpectError(
            value: "not_a_url",
            type: .url,
            expectedMessage: Strings.Validator.urlInvalid
        )
    }

    func testValidateNumeric_Valid() {
        validateAndExpectNoError(value: "123456", type: .numeric)
    }

    func testValidateNumeric_Invalid() {
        validateAndExpectError(
            value: "abc123",
            type: .numeric,
            expectedMessage: Strings.Validator.numericInvalid
        )
    }

    func testValidateNonEmpty_Valid() {
        validateAndExpectNoError(value: "Some text", type: .nonEmpty)
    }

    func testValidateNonEmpty_Empty() {
        validateAndExpectError(
            value: "",
            type: .nonEmpty,
            expectedMessage: Strings.Validator.fieldEmpty
        )
    }

    func testValidateFullName_Valid() {
        validateAndExpectNoError(value: "John Doe", type: .fullName)
    }

    func testValidateFullName_ConsecutiveSpaces() {
        validateAndExpectError(
            value: "John  Doe",
            type: .fullName,
            expectedMessage: Strings.Validator.fullNameConsecutiveSpaces
        )
    }

    func testValidateFullName_InvalidCharacters() {
        validateAndExpectError(
            value: "John123",
            type: .fullName,
            expectedMessage: Strings.Validator.fullNameInvalid
        )
    }

    func testValidateCustom_Valid() {
        LoggerHelper.shared.info("🛠 Testing custom validator directly")

        let customValidator = ValidatorHelper(type: .custom { value in
            return value.contains("custom") ? nil : "Must contain 'custom'"
        })

        let validValue = "this is custom"
        let errorMessage = customValidator.validate(validValue)

        if let errorMessage {
            LoggerHelper.shared.error("❌ Unexpected error for valid custom input: \(errorMessage)")
        } else {
            LoggerHelper.shared.info("✅ Custom validator passed for input: \(validValue)")
        }
        XCTAssertNil(errorMessage, "Custom validator should pass")

        let invalidValue = "invalid"
        let error = customValidator.validate(invalidValue)

        if let error {
            LoggerHelper.shared.warning("⚠️ Expected failure for invalid custom input: \(error)")
        } else {
            LoggerHelper.shared.error("❌ Expected error but got nil for invalid custom input")
        }
        XCTAssertEqual(error, "Must contain 'custom'", "Custom validator should fail with correct message")
    }
}
