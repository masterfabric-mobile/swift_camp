import UIKit
protocol UIApplicationProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: UIApplicationProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        self.open(url, options: options, completionHandler: completion)
    }
}
protocol LoggerHelperProtocol {
    func error(_ message: String)
}
extension LoggerHelper: LoggerHelperProtocol {}

struct DeepLinkHelper {

    /// Attempts to open a deep link.
    /// - Parameters:
    ///   - deepLinkString: The deep link to open (e.g., "myapp://some/resource").
    ///   - application: Allows injecting a testable UIApplication instance, defaults to `UIApplication.shared`.
    ///   - logger: Allows injecting a testable LoggerHelper instance, defaults to `LoggerHelper.shared`.
    static func open(_ deepLinkString: String, application: UIApplicationProtocol = UIApplication.shared, logger: LoggerHelperProtocol = LoggerHelper.shared) {
        guard let deepLinkURL = URL(string: deepLinkString) else {
            logger.error("❌ The deep link provided is invalid.")
            return
        }
        guard application.canOpenURL(deepLinkURL) else {
            logger.error("🚫 The required application is not installed on this device.")
            return
        }

        application.open(deepLinkURL, options: [:]) { success in
            if !success {
                logger.error("⚠️ Failed to open the application.")
            }
        }
    }
}
