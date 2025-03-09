import XCTest
import FirebaseAnalytics
import FirebaseCrashlytics
import FirebasePerformance
@testable import SwiftCampDevs

final class FirebaseHelperTests: XCTestCase {
    // MARK: - Setup & Teardown
    override func setUp() {
        super.setUp()
        print("Setup: FirebaseHelper test initialization.")
    }
    override func tearDown() {
        print("Teardown: FirebaseHelper test cleanup.")
        super.tearDown()
    }
    // MARK: - Firebase Analytics Tests
    func testEventLogging() {
        print("Starting testEventLogging...")
        let eventLog = EventLog(name: "test_event", parameters: ["key": "value"])
        eventLog.log()
        print("Finished testEventLogging.")
    }
    func testScreenLogging() {
        print("Starting testScreenLogging...")
        let screenLog = ScreenLog(screenName: "TestScreen", screenClass: "TestClass")
        screenLog.log()
        print("Finished testScreenLogging.")
    }
    func testUserPropertyLogging() {
        print("Starting testUserPropertyLogging...")
        let userProperty = UserPropertyLog(name: "test_property", value: "test_value")
        userProperty.log()
        print("Finished testUserPropertyLogging.")
    }
    // MARK: - Firebase Crashlytics Test
    func testErrorLogging() {
        print("Starting testErrorLogging...")
        let error = NSError(domain: "TestDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "Test error message"])
        let errorLog = ErrorLog(error: error, isFatal: false)
        errorLog.log()
        print("Finished testErrorLogging.")
    }
    // MARK: - Firebase Performance Test
    func testPerformanceLogging() {
        print("Starting testPerformanceLogging...")
        let performanceLog = PerformanceLog(metricName: "test_metric", value: 1.5)
        performanceLog.log()
        print("Finished testPerformanceLogging.")
    }
    // MARK: - Device Info Logging Test
    func testDeviceInfoLogging() {
        print("Starting testDeviceInfoLogging...")
        let deviceLog = DeviceInfoLog()
        deviceLog.log()
        print("Finished testDeviceInfoLogging.")
    }
}
