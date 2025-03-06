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
    func info(_ message: String)
    func debug(_ message: String)
    func warning(_ message: String)
    func error(_ message: String)
    func verbose(_ message: String)
}

extension LoggerHelper: LoggerHelperProtocol {}

struct DeepLinkHelper {

    /// Attempts to open a deep link.
    /// - Parameters:
    ///   - deepLinkString: The deep link to open (e.g., "myapp://some/resource").
    ///   - application: Allows injecting a testable UIApplication instance, defaults to `UIApplication.shared`.
    ///   - logger: Allows injecting a testable LoggerHelper instance, defaults to `LoggerHelper.shared`.
    static func open(_ deepLinkString: String, application: UIApplicationProtocol = UIApplication.shared, logger: LoggerHelperProtocol = LoggerHelper.shared) {
        
        logger.info("🔗 Attempting to open deep link: \(deepLinkString)")

        guard let deepLinkURL = URL(string: deepLinkString) else {
            logger.error("❌ Invalid deep link format: \(deepLinkString)")
            return
        }

        guard application.canOpenURL(deepLinkURL) else {
            logger.warning("🚫 App required to handle the deep link is not installed.")
            return
        }

        application.open(deepLinkURL, options: [:]) { success in
            if success {
                logger.info("✅ Successfully opened deep link: \(deepLinkString)")
            } else {
                logger.error("⚠️ Failed to open deep link: \(deepLinkString)")
            }
        }
    }
}
