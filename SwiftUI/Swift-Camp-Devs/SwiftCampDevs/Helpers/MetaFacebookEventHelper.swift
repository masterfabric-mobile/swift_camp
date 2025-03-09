import Foundation

// MARK: - MetaFacebookEventHelper
final class MetaFacebookEventHelper {
    
    // MARK: - Singleton Instance
    static let shared = MetaFacebookEventHelper()
    
    // MARK: - Properties
        // Replace with your Facebook App ID from developers.facebook.com
        private let appID: String = "YOUR_FACEBOOK_APP_ID"
        // Replace with your Access Token from developers.facebook.com
        private let accessToken: String = "YOUR_FACEBOOK_ACCESS_TOKEN"
        private let apiVersion = "v18.0"
        private let graphAPIURL: String
        
        // MARK: - Private Initializer (Singleton)
        private init() {
            self.graphAPIURL = "https://graph.facebook.com/\(apiVersion)/\(appID)/activities"
        }
    
    // MARK: - Log Standard Events
    /// Logs a standard event to Facebook
    /// - Parameters:
    ///   - event: Type of the event to be sent
    ///   - parameters: Additional data for the event (optional)
    func logEvent(_ event: FacebookEventType, parameters: [String: Any]? = nil) {
            let eventData: [String: Any] = [
                "event": event.rawValue,  // "event" parametresi eklendi
                "custom_events": [[
                    "_eventName": event.rawValue,
                    "custom_data": parameters ?? [:],
                    "_logTime": Int(Date().timeIntervalSince1970),
                    "advertiser_id": getAdvertiserID(),
                    "_appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                ]],
                "advertiser_id": getAdvertiserID(),
                "application_tracking_enabled": true,
                "app_id": appID
            ]
            sendEventToFacebook(eventData)
        }

        func logCustomEvent(eventName: String, parameters: [String: Any]) {
            let eventData: [String: Any] = [
                "event": "CUSTOM_APP_EVENTS",  // "event" parameters
                "custom_events": [[
                    "_eventName": eventName,
                    "custom_data": parameters,
                    "_logTime": Int(Date().timeIntervalSince1970),
                    "advertiser_id": getAdvertiserID(),
                    "_appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                ]],
                "advertiser_id": getAdvertiserID(),
                "application_tracking_enabled": true,
                "app_id": appID
            ]
            sendEventToFacebook(eventData)
        }

        private func sendEventToFacebook(_ eventData: [String: Any]) {
            var components = URLComponents(string: graphAPIURL)
            components?.queryItems = [
                URLQueryItem(name: "access_token", value: accessToken)
            ]
            
            guard let url = components?.url else {
                LoggerHelper.shared.error("Invalid Facebook API URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 30

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: eventData, options: [])
                // Debug için isteği logla
                if let jsonString = String(data: request.httpBody!, encoding: .utf8) {
                    LoggerHelper.shared.info("Facebook Event Request Payload: \(jsonString)")
                }
            } catch {
                LoggerHelper.shared.error("JSON Serialization Error: \(error.localizedDescription)")
                return
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    LoggerHelper.shared.error("Facebook Event API Request Failed: \(error.localizedDescription)")
                    return
                }

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    LoggerHelper.shared.info("Facebook API Response: \(responseString)")
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        LoggerHelper.shared.info("HTTP Status Code: \(httpResponse.statusCode)")
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    // MARK: - Get Advertising ID
    /// Returns a constant test advertising ID
    /// Should use actual IDFA in production
    private func getAdvertiserID() -> String {
        return "TEST_ADVERTISER_ID"
    }


// MARK: - Facebook Standard Events
/// Standard event types supported by Facebook
enum FacebookEventType: String {
    case addToCart = "AddToCart"
    case purchase = "Purchase"
    case viewContent = "ViewContent"
    case search = "Search"
    case lead = "Lead"
    
    case appLaunch = "AppLaunch"
    case appForeground = "AppForeground"
    case appBackground = "AppBackground"
    
    case mobileAppInstall = "MOBILE_APP_INSTALL"
    case customAppEvent = "CUSTOM_APP_EVENTS"
    case deferredAppLink = "DEFERRED_APP_LINK"
}
