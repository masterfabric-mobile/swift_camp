import Foundation
import UIKit

protocol AppLauncherProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}
extension UIApplication: AppLauncherProtocol {}

struct UniversalLinkHelper {
    static func openURL(_ urlString: String, application: AppLauncherProtocol = UIApplication.shared) {
        
        LoggerHelper.shared.info("🔗 Attempting to open universal link: \(urlString)")

        guard let url = URL(string: urlString) else {
            LoggerHelper.shared.error("❌ Invalid URL format: \(urlString)")
            return
        }

        application.open(url, options: [:]) { success in
            if success {
                LoggerHelper.shared.info("✅ Successfully opened universal link: \(urlString)")
            } else {
                LoggerHelper.shared.warning("🚫 Failed to open universal link: \(urlString)")
            }
        }
    }
}
