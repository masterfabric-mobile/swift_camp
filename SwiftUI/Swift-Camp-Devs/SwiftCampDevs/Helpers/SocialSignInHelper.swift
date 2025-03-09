import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import AuthenticationServices
import CryptoKit

final class SocialSignInHelper: ObservableObject {
    
    @Published var errorMessage: String?
    private var currentNonce: String?

    // MARK: - Google Login
    func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                self.errorMessage = "Google Sign-In failed: \(error.localizedDescription)"
                completion(.failure(error))
                return
            }

            guard let authentication = result?.user.idToken else {
                self.errorMessage = "Failed to get Google ID Token."
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.tokenString,
                accessToken: result!.user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = "Firebase Sign-In with Google failed: \(error.localizedDescription)"
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                }
            }
        }
    }

    // MARK: - Facebook Login
    func signInWithFacebook(completion: @escaping (Result<User, Error>) -> Void) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
            if let error = error {
                self.errorMessage = "Facebook Sign-In failed: \(error.localizedDescription)"
                completion(.failure(error))
                return
            }

            guard let result = result, !result.isCancelled else {
                self.errorMessage = "Facebook Sign-In was cancelled."
                return
            }

            guard let accessToken = AccessToken.current else {
                self.errorMessage = "Failed to get Facebook access token."
                return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = "Firebase Sign-In with Facebook failed: \(error.localizedDescription)"
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                }
            }
        }
    }

    // MARK: - GitHub Login
    func signInWithGitHub(completion: @escaping (Result<User, Error>) -> Void) {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]
        provider.customParameters = ["allow_signup": "false"]

        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                self.errorMessage = "GitHub login failed: \(error.localizedDescription)"
                completion(.failure(error))
                return
            }

            guard let credential = credential else {
                self.errorMessage = "Failed to get GitHub credential."
                return
            }

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = "Firebase GitHub login failed: \(error.localizedDescription)"
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                }
            }
        }
    }

    // MARK: - Apple Login
    func signInWithApple(request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
        request.requestedScopes = [.fullName, .email]
    }

    func handleAppleSignIn(result: Result<ASAuthorization, Error>, completion: @escaping (Result<User, Error>) -> Void) {
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
                        completion(.failure(error))
                    } else if let user = authResult?.user {
                        completion(.success(user))
                    }
                }
            }
        case .failure(let error):
            self.errorMessage = "Apple Sign-In failed: \(error.localizedDescription)"
            completion(.failure(error))
        }
    }

    // MARK: - Nonce & Hashing Helpers
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
}
