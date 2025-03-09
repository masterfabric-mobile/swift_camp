import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var errorMessage: String?
    @State private var isSuccess: Bool = false
    @State private var isLoading: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            Text("Enter your email address to receive a password reset link.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            TextField("Your email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            if isSuccess {
                Text("Password reset link sent! Check your email.")
                    .foregroundColor(.green)
                    .font(.footnote)
            }

            Button(action: resetPassword) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Send Reset Link")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            Spacer()
        }
        .padding()
    }

    private func resetPassword() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            return
        }

        errorMessage = nil
        isSuccess = false
        isLoading = true

        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isSuccess = true
            }
        }
    }
}
