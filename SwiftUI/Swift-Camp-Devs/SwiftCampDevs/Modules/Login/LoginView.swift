import SwiftUI
import FirebaseAuth
import FacebookLogin
import AuthenticationServices
import CryptoKit

struct LoginView: View {
    @ObservedObject var presenter: LoginPresenter
    @StateObject private var socialSignInHelper = SocialSignInHelper()


    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var currentNonce: String?
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Hi, Welcome! 👋")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Email address or phone number")
                    HStack {
                        TextField("Your email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .onAppear {
                                email = ""
                                password = ""
                                loadRememberedEmail()
                            }
                            .onChange(of: email) { newEmail in
                                checkRememberedPassword(for: newEmail)
                            }
                    }
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                    Text("Password")
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }

                HStack {
                    Text("Remember me")
                    Toggle("", isOn: $rememberMe)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .black))
                    
                    Spacer()
                    
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot password?")
                    }
                    .foregroundColor(.blue)
                }


                if let error = socialSignInHelper.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button(action: loginWithFirebase) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Log in")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                Text("Or with")
                    .font(.footnote)
                    .foregroundColor(.gray)

                Button(action: {
                    socialSignInHelper.signInWithGoogle { result in
                        switch result {
                        case .success:
                            presenter.handleSuccessfulLogin()
                        case .failure(let error):
                            socialSignInHelper.errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    HStack {
                        Image("googleLogo")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Continue with Google")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                Button(action: {
                    socialSignInHelper.signInWithGitHub { result in
                        switch result {
                        case .success:
                            presenter.handleSuccessfulLogin()
                        case .failure(let error):
                            socialSignInHelper.errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    HStack {
                        Image("githubLogo")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Continue with GitHub")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                Button(action: {
                    socialSignInHelper.signInWithFacebook { result in
                        switch result {
                        case .success:
                            presenter.handleSuccessfulLogin()
                        case .failure(let error):
                            socialSignInHelper.errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    HStack {
                        Image("facebookLogo")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                        Text("Continue with Facebook")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                SignInWithAppleButton(
                    .signIn,
                    onRequest: configureAppleRequest,
                    onCompletion: { result in
                        socialSignInHelper.handleAppleSignIn(result: result) { result in
                            switch result {
                            case .success:
                                presenter.handleSuccessfulLogin()
                            case .failure(let error):
                                socialSignInHelper.errorMessage = error.localizedDescription
                            }
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .cornerRadius(8)

                Spacer()
                HStack {
                    Text("Don’t have an account?")
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
    private func loginWithFirebase() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }
        isLoading = true
        errorMessage = nil
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                if rememberMe {
                    KeychainHelper.shared.save(self.email, forKey: "savedEmail")
                    KeychainHelper.shared.save(self.password, forKey: "savedPassword")
                } else {
                    KeychainHelper.shared.delete(forKey: "savedEmail")
                    KeychainHelper.shared.delete(forKey: "savedPassword")
                }
                presenter.handleSuccessfulLogin()
            }
        }
    }
    private func randomNonceString(length: Int = 32) -> String {
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce.")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.map { String(format: "%02x", $0) }.joined()
    }
    private func configureAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
        request.requestedScopes = [.fullName, .email]
    }
    private func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let identityToken = appleIDCredential.identityToken,
                      let tokenString = String(data: identityToken, encoding: .utf8),
                      let nonce = currentNonce else {
                    self.errorMessage = "Invalid Apple Sign-In request."
                    return
                }
                let credential = OAuthProvider.credential(
                    withProviderID: "apple.com",
                    idToken: tokenString,
                    rawNonce: nonce
                )
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        self.errorMessage = "Apple Sign-In failed: \(error.localizedDescription)"
                    } else {
                        presenter.handleSuccessfulLogin()
                    }
                }
            }
        case .failure(let error):
            self.errorMessage = "Apple Sign-In failed: \(error.localizedDescription)"
        }
    }
    private func loadRememberedEmail() {
        if let savedEmail = KeychainHelper.shared.retrieve(forKey: "savedEmail") {
            if !email.isEmpty {
                self.email = savedEmail
            }
        }
    }
    private func checkRememberedPassword(for newEmail: String) {
        if let savedEmail = KeychainHelper.shared.retrieve(forKey: "savedEmail"),
           let savedPassword = KeychainHelper.shared.retrieve(forKey: "savedPassword"),
           newEmail == savedEmail {
            self.password = savedPassword
        } else {
            self.password = ""
        }}
}
