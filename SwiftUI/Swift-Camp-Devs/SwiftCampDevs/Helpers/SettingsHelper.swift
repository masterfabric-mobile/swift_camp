import UIKit

/// A helper class that provides functionality to open various iOS system settings pages
class SettingsHelper {
    static let shared = SettingsHelper()
    
    private init() {}
    
    enum SettingsType {
        case appSettings
        case notificationSettings
        case microfonSettings
        case cameraSettings
        case locationSettings
        case photosSettings
        case siriSettings
        case wifiSettings
        case bluetoothSettings
        case cellularSettings
        case batterySettings
        case privacySettings
        
        /// Returns the URL string for the corresponding settings page
        var urlString: String {
            switch self {
                case .appSettings: return UIApplication.openSettingsURLString
                case .notificationSettings:
                            if #available(iOS 16.0, *) {
                                return UIApplication.openNotificationSettingsURLString
                            } else {
                                return UIApplication.openSettingsURLString
                            }
                case .microfonSettings: return "App-Prefs:Privacy&path=MICROPHONE"
                case .cameraSettings: return "App-Prefs:Privacy&path=CAMERA"
                case .locationSettings: return "App-Prefs:Privacy&path=LOCATION"
                case .photosSettings: return "App-Prefs:Privacy&path=PHOTOS"
                case .siriSettings: return "App-Prefs:SIRI"
                case .wifiSettings: return "App-Prefs:WIFI"
                case .bluetoothSettings: return "App-Prefs:Bluetooth"
                case .cellularSettings: return "App-Prefs:MOBILE_DATA_SETTINGS_ID"
                case .batterySettings: return "App-Prefs:BATTERY_USAGE"
                case .privacySettings: return "App-Prefs:Privacy"
            }
        }
    }
    
    /// Opens the specified iOS system settings page
    /// - Parameters:
    ///   - type: The type of settings to open
    ///   - completion: Callback closure that returns a boolean indicating success or failure
    func openSettings(_ type: SettingsType, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: type.urlString) else {
            print("Invalid settings URL")
            completion(false)
            return
        }
        
        UIApplication.shared.open(url) { success in
            if success {
                print("Successfully opened settings: \(type)")
            } else {
                print("Failed to open settings: \(type)")
            }
            completion(success)
        }
    }
}
