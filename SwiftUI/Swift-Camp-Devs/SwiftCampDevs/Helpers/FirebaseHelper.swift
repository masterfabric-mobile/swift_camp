import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics
import FirebasePerformance

// MARK: - Log Types
enum LogType {
    case event(EventLog)
    case screen(ScreenLog)
    case userProperty(UserPropertyLog)
    case error(ErrorLog)
    case performance(PerformanceLog)
}

// MARK: - Loggable Protocol
protocol Loggable {
    var logType: LogType { get }
    func log()
}

// MARK: - Event Logs
struct EventLog: Loggable {
    let name: String
    let parameters: [String: Any]?

    var logType: LogType {
        return .event(self)
    }

    func log() {
        Analytics.logEvent(name, parameters: parameters)
        LoggerHelper.shared.info("Event logged: \(name), Parameters: \(String(describing: parameters))")
    }

    static func postViewed(postId: String) -> EventLog {
        return EventLog(name: "post_viewed", parameters: ["post_id": postId])
    }

    static func notificationOpened(notificationId: String) -> EventLog {
        return EventLog(name: "notification_opened", parameters: ["notification_id": notificationId])
    }
}

// MARK: - Screen Logs
struct ScreenLog: Loggable {
    let screenName: String
    let screenClass: String?

    var logType: LogType {
        return .screen(self)
    }

    func log() {
        Analytics.logEvent("screen_view", parameters: [
            "screen_name": screenName,
            "screen_class": screenClass ?? "unknown"
        ])
        LoggerHelper.shared.info("Screen Logged: \(screenName), Class: \(screenClass ?? "unknown")")
    }
}

// MARK: - User Property Logs
struct UserPropertyLog: Loggable {
    let name: String
    let value: String

    var logType: LogType {
        return .userProperty(self)
    }

    func log() {
        Analytics.setUserProperty(value, forName: name)
        LoggerHelper.shared.info("User Property Set: \(name) = \(value)")
    }
}

// MARK: - Error Logs
struct ErrorLog: Loggable {
    let error: Error
    let isFatal: Bool

    var logType: LogType {
        return .error(self)
    }

    func log() {
        if isFatal {
            Crashlytics.crashlytics().record(error: error)
            LoggerHelper.shared.error("Fatal Error Logged: \(error.localizedDescription)")
        } else {
            Crashlytics.crashlytics().log(error.localizedDescription)
            LoggerHelper.shared.warning("Non-Fatal Error Logged: \(error.localizedDescription)")
        }
    }
}

// MARK: - Performance Logs
struct PerformanceLog: Loggable {
    let metricName: String
    let value: Double

    var logType: LogType {
        return .performance(self)
    }

    func log() {
        let trace = Performance.startTrace(name: metricName)
        trace?.incrementMetric("value", by: Int64(value))
        trace?.stop()
        LoggerHelper.shared.debug("Performance Metric Logged: \(metricName) = \(value)")
    }
}

// MARK: - Device Info Logs
struct DeviceInfoLog: Loggable {
    var logType: LogType {
        return .event(EventLog(name: "Device_Info", parameters: nil))
    }
    
    func log() {
        let device = UIDevice.current
        let screen = UIScreen.main
        
        // UUID bilgisi (kullanıcı izni alındıktan sonra kullanılabilir)
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? "Unknown UUID"
        
        
        LoggerHelper.shared.info("Logging device information...")
        
        let deviceInfo: [String: Any] = [
            "device_model": device.model,
            "os_name": device.systemName,
            "os_version": device.systemVersion,
            "screen_width": screen.bounds.size.width,
            "screen_height": screen.bounds.size.height,
            "device_name": device.name,
            "uuid": uuid
        ]
        
        LoggerHelper.shared.debug("Device Info: \(deviceInfo)")
        
        Analytics.logEvent("device_info_logged", parameters: deviceInfo)
        
        Analytics.setUserProperty(device.model, forName: "device_model")
        Analytics.setUserProperty(device.systemVersion, forName: "os_version")
        Analytics.setUserProperty("\(screen.bounds.size.width)x\(screen.bounds.size.height)", forName: "screen_resolution")
        Analytics.setUserProperty(uuid, forName: "user_uuid")
        
        LoggerHelper.shared.info("Firebase Analytics device info logged.")
        
        Crashlytics.crashlytics().setCustomValue(device.model, forKey: "device_model")
        Crashlytics.crashlytics().setCustomValue(device.systemVersion, forKey: "os_version")
        Crashlytics.crashlytics().setCustomValue("\(screen.bounds.size.width)x\(screen.bounds.size.height)", forKey: "screen_resolution")
        Crashlytics.crashlytics().setCustomValue(uuid, forKey: "user_uuid")
        
        LoggerHelper.shared.info("Crashlytics device info logged.")
        
    }
    
    // MARK: - Permission Function
    
    func checkPermissionAndLog() {
        let isPermissionGranted = UserDefaults.standard.bool(forKey: "permission_granted")
            
        if isPermissionGranted {
        LoggerHelper.shared.info("Permission granted. Proceeding with logging.")
        log()
        } else {
            LoggerHelper.shared.warning("Permission not granted. Cannot log device information.")
        }
    }
}

// MARK: - Log Manager
class LogManager {
    static let shared = LogManager()
    private init() {}
    
    func log(_ loggable: Loggable) {
        loggable.log()
        LoggerHelper.shared.verbose("Logging: \(loggable.logType)")
    }
}
