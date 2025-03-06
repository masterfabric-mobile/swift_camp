import XCTest
@testable import SwiftCampDevs

class MockUIApplication: UIApplicationProtocol {
    var canOpenURLMock: Bool = true
    var openURLCalled = false
    var completionSuccess = true

    func canOpenURL(_ url: URL) -> Bool {
        return canOpenURLMock
    }

    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?) {
        openURLCalled = true
        completion?(completionSuccess)
    }
}
class MockLoggerHelper: LoggerHelperProtocol {
    var lastLoggedMessage: String?

    func info(_ message: String) {
        lastLoggedMessage = message
    }

    func debug(_ message: String) {
        lastLoggedMessage = message
    }

    func warning(_ message: String) {
        lastLoggedMessage = message
    }

    func error(_ message: String) {
        lastLoggedMessage = message
    }

    func verbose(_ message: String) {
        lastLoggedMessage = message
    }
}

class DeepLinkHelperTests: XCTestCase {
    
    func test_Open_AppNotInstalled_ShouldLogWarning() {
        let mockApp = MockUIApplication()
        let mockLogger = MockLoggerHelper()
        mockApp.canOpenURLMock = false

        let url = "myapp://profile"
        DeepLinkHelper.open(url, application: mockApp, logger: mockLogger)

        XCTAssertEqual(mockLogger.lastLoggedMessage, "🚫 App required to handle the deep link is not installed.", "⚠️ App not installed warning should have been logged.")
    }

    func test_Open_FailedToOpen_ShouldLogError() {
        let mockApp = MockUIApplication()
        let mockLogger = MockLoggerHelper()
        mockApp.completionSuccess = false

        let url = "myapp://settings"
        DeepLinkHelper.open(url, application: mockApp, logger: mockLogger)

        XCTAssertEqual(mockLogger.lastLoggedMessage, "⚠️ Failed to open deep link: \(url)", "❌ Application opening failure should have been logged.")
    }

    func test_Open_SuccessfulDeepLink_ShouldLogInfo() {
        let mockApp = MockUIApplication()
        let mockLogger = MockLoggerHelper()
        let url = "myapp://dashboard"

        DeepLinkHelper.open(url, application: mockApp, logger: mockLogger)

        XCTAssertEqual(mockLogger.lastLoggedMessage, "✅ Successfully opened deep link: \(url)", "ℹ️ Deep link success message should have been logged.")
    }
}
