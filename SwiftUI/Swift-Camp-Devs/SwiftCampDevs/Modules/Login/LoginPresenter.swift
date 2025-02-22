import FirebaseAuth
import GoogleSignIn
import UIKit
import FacebookLogin
import AuthenticationServices
import CryptoKit

final class LoginPresenter: ObservableObject {
    private let wireframe: LoginWireframeInterface
    private var currentNonce: String?

    init(wireframe: LoginWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Firebase Email/Password Login
    func loginWithEmailPassword(email: String, password: String, rememberMe: Bool) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Email/Password login failed: \(error.localizedDescription)")
            } else {
                print("User signed in with Email: \(email)")
                if rememberMe {
                    self.handleRememberMe(email: email, password: password)
                }

                self.handleSuccessfulLogin()
            }
        }
    }

    // MARK: - Google Login
    func handleGoogleLogin() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }

            guard let authentication = result?.user.idToken else {
                print("Failed to get Google ID Token")
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.tokenString,
                accessToken: result!.user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In with Google failed: \(error.localizedDescription)")
                } else {
                    print("User signed in with Google: \(authResult?.user.email ?? "No email")")
                    self.handleSuccessfulLogin()
                }
            }
        }
    }
    // MARK: - GitHub Login
    func handleGitHubLogin() {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]
        provider.customParameters = ["allow_signup": "false"]
        provider.getCredentialWith(nil) { [weak self] credential, error in
            if let error = error {
                print("GitHub login failed: \(error.localizedDescription)")
                return
            }
            guard let credential = credential else {
                print("Failed to get GitHub credential")
                return
            }
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase GitHub login failed: \(error.localizedDescription)")
                } else {
                    print("User signed in with GitHub: \(authResult?.user.email ?? "No email")")
                    self?.handleSuccessfulLogin()
                }
            }
        }
    }
    // MARK: - Facebook Login (No Remember Me)
    func handleFacebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { [weak self] result, error in
            if let error = error {
                print("Facebook login failed: \(error.localizedDescription)")
                return
            }
            guard let result = result, !result.isCancelled else {
                print("Facebook login was cancelled.")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get Facebook access token.")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In with Facebook failed: \(error.localizedDescription)")
                } else {
                    print("User signed in with Facebook: \(authResult?.user.email ?? "No email")")
                    self?.handleSuccessfulLogin()
                }
            }
        }
    }
    // MARK: - Apple Login
    func handleAppleLogin(authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            print("Apple Sign-In User ID: \(userID)")

            guard let identityToken = appleIDCredential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8),
                  let nonce = currentNonce else {
                print("Failed to get Apple ID token or nonce.")
                return
            }
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: tokenString,
                rawNonce: nonce
            )
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In with Apple failed: \(error.localizedDescription)")
                } else {
                    print("User signed in with Apple: \(authResult?.user.email ?? "No email")")
                    self.handleSuccessfulLogin()
                }
            }
        } else {
            print("Apple Sign-In failed: No credential found.")
        }
    }
    // MARK: - Remember Me
    private func handleRememberMe(email: String, password: String) {
        if let savedEmail = KeychainHelper.shared.retrieve(forKey: "savedEmail"), savedEmail != email {
            print("⚠️ Different user detected, previous record is being deleted...")
            KeychainHelper.shared.delete(forKey: "savedEmail")
            KeychainHelper.shared.delete(forKey: "savedPassword")
        }
        KeychainHelper.shared.save(email, forKey: "savedEmail")
        KeychainHelper.shared.save(password, forKey: "savedPassword")
    }
    // MARK: - Successful Login
    func handleSuccessfulLogin() {
        print("Login was successful!")
        wireframe.navigateToHome()
    }
}
