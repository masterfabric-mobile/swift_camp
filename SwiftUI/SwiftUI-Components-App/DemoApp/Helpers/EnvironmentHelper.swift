import Foundation

// MARK: - Environment Types
enum EnvironmentType: String {
    case dev = "DEV"
    case uat = "UAT"
    case prod = "PROD"
}

// MARK: - Environment Helper
struct EnvironmentHelper {
    static let shared = EnvironmentHelper()
    
    // MARK: - Properties
    private let infoDictionary: [String: Any]
    
    // MARK: - Initializer
    private init() {
        do {
            guard let path = Bundle.main.path(forResource: "EnvironmentConfig", ofType: "plist"),
                  let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
                throw EnvironmentError.fileNotFound
            }
            self.infoDictionary = dict
            
            // Log the environment type to console
            if let environment = dict["Environment"] as? String {
                LoggerHelper.shared.info("🚀 Environment Loaded: \(environment)")
            } else {
                LoggerHelper.shared.warning("⚠️ Environment key not found in plist!")
            }
        } catch {
            LoggerHelper.shared.error("❌ Error initializing EnvironmentHelper: \(error.localizedDescription)")
            self.infoDictionary = [:] // Fallback to an empty dictionary
        }
    }
    
    // MARK: - Accessors
    
    /// Returns the current environment type (e.g., DEV, UAT, PROD).
    var environment: EnvironmentType {
        do {
            guard let value = infoDictionary["Environment"] as? String,
                  let env = EnvironmentType(rawValue: value) else {
                throw EnvironmentError.invalidEnvironmentValue
            }
            LoggerHelper.shared.debug("🔍 Environment: \(env.rawValue)")
            return env
        } catch {
            LoggerHelper.shared.error("⚠️ Error fetching environment: \(error.localizedDescription). Defaulting to DEV.")
            return .dev
        }
    }
    
    /// Returns the base API URL for the current environment.
    var apiBaseUrl: String {
        do {
            guard let url = infoDictionary["API_BASE_URL"] as? String else {
                throw EnvironmentError.missingKey(key: "API_BASE_URL")
            }
            LoggerHelper.shared.debug("🔗 API Base URL: \(url)")
            return url
        } catch {
            LoggerHelper.shared.error("⚠️ Error fetching API_BASE_URL: \(error.localizedDescription). Defaulting to empty URL.")
            return "https://dev.masterfabric.co/api"
        }
    }
    
    /// Returns the API key for the current environment.
    var apiKey: String {
        do {
            guard let key = infoDictionary["API_KEY"] as? String else {
                throw EnvironmentError.missingKey(key: "API_KEY")
            }
            LoggerHelper.shared.debug("🔑 API Key: \(key)")
            return key
        } catch {
            LoggerHelper.shared.error("⚠️ Error fetching API_KEY: \(error.localizedDescription). Defaulting to empty API key.")
            return "default-api-key"
        }
    }

    /// Returns the OneSignal App ID for the current environment.
    var oneSignalAppID: String {
        do {
            guard let appID = infoDictionary["ONESIGNAL_APP_ID"] as? String else {
                throw EnvironmentError.missingKey(key: "ONESIGNAL_APP_ID")
            }
            LoggerHelper.shared.debug("🔑 OneSignal App ID: \(appID)")
            return appID
        } catch {
            LoggerHelper.shared.error("⚠️ Error fetching OneSignalAppID: \(error.localizedDescription). Defaulting to empty App ID.")
            return ""
        }
    }
    
    /// Returns the GitHub repository API URL.
    var githubRepoApi: String {
        do {
            guard let url = infoDictionary["GITHUB_REPO_API"] as? String else {
                throw EnvironmentError.missingKey(key: "GITHUB_REPO_API")
            }
            LoggerHelper.shared.debug("📂 GitHub Repo API: \(url)")
            return url
        } catch {
            LoggerHelper.shared.error("⚠️ Error fetching GITHUB_REPO_API: \(error.localizedDescription). Defaulting to empty GitHub API URL.")
            return "https://api.github.com/repos/default"
        }
    }
    
    /// Returns the encryption key for the current environment.
    var encryptionKey: String {
        do {
            guard let key = infoDictionary["ENCRYPTION_KEY"] as? String else {
                throw EnvironmentError.missingKey(key: "ENCRYPTION_KEY")
            }
            LoggerHelper.shared.debug("🔒 Encryption Key: \(key)")
            return key
        } catch {
            LoggerHelper.shared.error("⚠️ Error fetching ENCRYPTION_KEY: \(error.localizedDescription). Defaulting to empty encryption key.")
            return "default-encryption-key"
        }
    }
}

// MARK: - Environment Errors
enum EnvironmentError: Error {
    case fileNotFound
    case invalidEnvironmentValue
    case missingKey(key: String)
}
