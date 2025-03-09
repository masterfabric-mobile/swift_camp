import Foundation
import Mixpanel
import UIKit


// MARK: - Log Types
enum MixpanelLogType {
    case event(MixpanelEventLog)
    case screen(MixpanelScreenLog)
    case userProperty(MixpanelUserPropertyLog)
    case error(MixpanelErrorLog)
}

// MARK: - Loggable Protocol
protocol MixpanelLoggable {
    var logType: MixpanelLogType { get }
    func log()
}

// MARK: - Event Logs
struct MixpanelEventLog: MixpanelLoggable {
    let name: String
    let parameters: [String: Any]?

    var logType: MixpanelLogType {
        return .event(self)
    }

    func log() {
        let castedParameters = parameters as? Properties
        Mixpanel.mainInstance().track(event: name, properties: castedParameters)
        print("Mixpanel Event Logged: \(name), Parameters: \(String(describing: parameters))")
    }

    static func postViewed(postId: String) -> MixpanelEventLog {
        return MixpanelEventLog(name: "post_viewed", parameters: ["post_id": postId])
    }

    static func notificationOpened(notificationId: String) -> MixpanelEventLog {
        return MixpanelEventLog(name: "notification_opened", parameters: ["notification_id": notificationId])
    }
}

// MARK: - Screen Logs
struct MixpanelScreenLog: MixpanelLoggable {
    let screenName: String
    let screenClass: String?

    var logType: MixpanelLogType {
        return .screen(self)
    }

    func log() {
        Mixpanel.mainInstance().track(event: "screen_view", properties: [
            "screen_name": screenName,
            "screen_class": screenClass ?? "unknown"
        ])
        print("Mixpanel Screen Logged: \(screenName), Class: \(screenClass ?? "unknown")")
    }
}

// MARK: - User Property Logs
struct MixpanelUserPropertyLog: MixpanelLoggable {
    let name: String
    let value: String

    var logType: MixpanelLogType {
        return .userProperty(self)
    }

    func log() {
        Mixpanel.mainInstance().people.set(property: name, to: value)
        print("Mixpanel User Property Set: \(name) = \(value)")
    }
}

// MARK: - Error Logs
struct MixpanelErrorLog: MixpanelLoggable {
    let error: Error

    var logType: MixpanelLogType {
        return .error(self)
    }

    func log() {
        Mixpanel.mainInstance().track(event: "error_logged", properties: ["error_message": error.localizedDescription])
        print("Mixpanel Error Logged: \(error.localizedDescription)")
    }
}

// MARK: - Device Info Logs
struct MixpanelDeviceInfoLog: MixpanelLoggable {
    var logType: MixpanelLogType {
        return .event(MixpanelEventLog(name: "Device_Info", parameters: nil))
    }
    
    func log() {
        let device = UIDevice.current
        let screen = UIScreen.main
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? "Unknown UUID"
        
        let deviceInfo: Properties = [
            "device_model": device.model,
            "os_name": device.systemName,
            "os_version": device.systemVersion,
            "device_name": device.name,
            "uuid": uuid
        ]
        
        Mixpanel.mainInstance().track(event: "device_info_logged", properties: deviceInfo)
        Mixpanel.mainInstance().people.set(properties: deviceInfo)
        
        print("Mixpanel Device Info Logged: \(deviceInfo)")
    }
}

// MARK: - Log Manager
class MixpanelLogManager {
    static let shared = MixpanelLogManager()
    private init() {}
    
    func log(_ loggable: MixpanelLoggable) {
        loggable.log()
        print("Mixpanel Logging: \(loggable.logType)")
    }
}
