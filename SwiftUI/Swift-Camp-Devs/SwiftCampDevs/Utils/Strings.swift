/*struct Strings {
    // MARK: - Common UI Text
    static let appName = "SwiftUI Components"
    static let ok = "OK"
    static let cancel = "Cancel"
    static let back = "Back"
    static let done = "Done"
    static let error = "Error"
    static let success = "Success"
    static let warning = "Warning"
    
    // MARK: - Navigation
    static let home = "Home"
    static let settings = "Settings"
    static let profile = "Profile"
    
    // MARK: - Error Messages
    static let genericError = "Something went wrong. Please try again."
    static let networkError = "Network connection error"
    static let invalidInput = "Invalid input. Please check and try again."
    
    // MARK: - Success Messages 
    static let dataSaved = "Data saved successfully"
    static let uploadComplete = "Upload completed"
    
    // MARK: - Button Titles
    static let saveButton = "Save"
    static let deleteButton = "Delete"
    static let updateButton = "Update"
}
*/
import SwiftUI
 
// Strings.swift
enum Strings {
    enum Portfolio {
        static let myPortfolio = "My Portfolio"
        static let addNewProject = "Add new project"
        static let projectNamePlaceholder = "Project Name"
        static let projectDescriptionPlaceholder = "Project Description"
        static let techStackPlaceholder = "Tech Stack"
        static let cancel = "Cancel"
        static let add = "Add"
    }
 
    enum Alerts {
        static let errorTitle = "Error"
        static let successTitle = "Success"
        static let ok = "OK"
    }
 
    enum Buttons {
        static let save = "Save"
        static let delete = "Delete"
        static let edit = "Edit"
        static let retry = "Retry"
        static let confirm = "Confirm"
    }
 
    enum Errors {
        static let emptyProjectName = "Project name cannot be empty."
        static let emptyDescription = "Description cannot be empty."
        static let invalidInput = "Invalid input. Please try again."
    }
 
    enum Placeholders {
        static let search = "Search..."
        static let email = "Enter your email"
        static let password = "Enter your password"
    }
    enum Validator {
            static let usernameInvalid = "Username can only contain letters, numbers, and underscores."
            static let passwordSpaces = "Password must not contain spaces."
            static let passwordInvalid = "Password must contain at least 8 characters, including an uppercase letter, a lowercase letter, a number, and a special character."
            static let emailInvalid = "Invalid email format."
            static let fullNameConsecutiveSpaces = "Full name must not contain consecutive spaces."
            static let fullNameInvalid = "Full name must contain only letters and spaces."
            static let phoneNumberInvalid = "Phone number must match international format (e.g., +905551234567)."
            static let urlInvalid = "Invalid URL format."
            static let numericInvalid = "Only numeric characters are allowed."
            static let fieldEmpty = "This field cannot be empty."

            static func minLengthError(field: String, min: Int) -> String {
                return "\(field) must be at least \(min) characters long."
            }

            static func maxLengthError(field: String, max: Int) -> String {
                return "\(field) cannot exceed \(max) characters."
            }
        }
}
 
// SwiftUI Preview
struct StringsPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Portfolio Section
                SectionView(
                    title: "Portfolio",
                    content: {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Strings.Portfolio.myPortfolio)
                                .font(.title)
                                .foregroundColor(.primary)
 
                            Button(Strings.Portfolio.addNewProject) {
                                print("Add new project tapped")
                            }
                            .buttonStyle(.borderedProminent)
 
                            TextField(Strings.Portfolio.projectNamePlaceholder, text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
 
                            TextField(Strings.Portfolio.projectDescriptionPlaceholder, text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }
                )
 
                // Alerts Section
                SectionView(
                    title: "Alerts",
                    content: {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Strings.Alerts.errorTitle)
                                .font(.headline)
                                .foregroundColor(.red)
 
                            Text(Strings.Alerts.successTitle)
                                .font(.headline)
                                .foregroundColor(.green)
 
                            Button(Strings.Alerts.ok) {
                                print("OK tapped")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                )
 
                // Buttons Section
                SectionView(
                    title: "Buttons",
                    content: {
                        VStack(alignment: .leading, spacing: 10) {
                            Button(Strings.Buttons.save) {
                                print("Save tapped")
                            }
                            .buttonStyle(.borderedProminent)
 
                            Button(Strings.Buttons.delete) {
                                print("Delete tapped")
                            }
                            .buttonStyle(.bordered)
 
                            Button(Strings.Buttons.edit) {
                                print("Edit tapped")
                            }
                            .buttonStyle(.bordered)
 
                            Button(Strings.Buttons.retry) {
                                print("Retry tapped")
                            }
                            .buttonStyle(.bordered)
 
                            Button(Strings.Buttons.confirm) {
                                print("Confirm tapped")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                )
 
                // Errors Section
                SectionView(
                    title: "Errors",
                    content: {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Strings.Errors.emptyProjectName)
                                .foregroundColor(.secondary)
                                .italic()
 
                            Text(Strings.Errors.emptyDescription)
                                .foregroundColor(.secondary)
                                .italic()
 
                            Text(Strings.Errors.invalidInput)
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                )
 
                // Placeholders Section
                SectionView(
                    title: "Placeholders",
                    content: {
                        VStack(alignment: .leading, spacing: 10) {
                            TextField(Strings.Placeholders.search, text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
 
                            TextField(Strings.Placeholders.email, text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
 
                            SecureField(Strings.Placeholders.password, text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }
                )
            }
            .padding()
        }
    }
}
 
// SectionView for organizing different parts of the preview
struct SectionView<Content: View>: View {
    let title: String
    let content: () -> Content
 
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
 
            content()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
 
// Preview Section
#Preview {
    StringsPreview()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Strings Preview")
}
