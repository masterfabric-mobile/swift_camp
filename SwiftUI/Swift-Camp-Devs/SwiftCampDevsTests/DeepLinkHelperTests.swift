import XCTest
@testable import SwiftCampDevs

// Mock UIApplication
class MockUIApplication: UIApplicationProtocol {
    var canOpenURLMock: Bool = true
    var openURLCalled = false
    var completionSuccess = true

    func canOpenURL(_ url: URL) -> Bool {
        //  Catch explicitly invalid URLs
        if url.absoluteString == "invalid_url" || url.scheme == nil || !url.absoluteString.contains("://") {
            return false
        }
        return canOpenURLMock
    }

    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?) {
        openURLCalled = true
        completion?(completionSuccess)
    }
}

//  Mock LoggerHelper
class MockLoggerHelper: LoggerHelperProtocol {
    var lastLoggedError: String?

    func error(_ message: String) {
        lastLoggedError = message
    }
}

class DeepLinkHelperTests: XCTestCase {
    func test_Open_ValidDeepLink_Success() {
        let mockApp = MockUIApplication()
        let mockLogger = MockLoggerHelper()
        let url = "myapp://home"

        DeepLinkHelper.open(url, application: mockApp, logger: mockLogger)

        XCTAssertTrue(mockApp.openURLCalled, "✅ The deep link should have been opened.")
    }
    func test_Open_AppNotInstalled_ShouldLogError() {
        let mockApp = MockUIApplication()
        let mockLogger = MockLoggerHelper()
        mockApp.canOpenURLMock = false

        let url = "myapp://profile"
        DeepLinkHelper.open(url, application: mockApp, logger: mockLogger)

        XCTAssertEqual(mockLogger.lastLoggedError, "🚫 The required application is not installed on this device.", "🚨 App not installed error should have been logged.")
    }
    func test_Open_FailedToOpen_ShouldLogError() {
        let mockApp = MockUIApplication()
        let mockLogger = MockLoggerHelper()
        mockApp.completionSuccess = false

        let url = "myapp://settings"
        DeepLinkHelper.open(url, application: mockApp, logger: mockLogger)

        XCTAssertEqual(mockLogger.lastLoggedError, "⚠️ Failed to open the application.", "❌ Application opening failure should have been logged.")
    }
}
