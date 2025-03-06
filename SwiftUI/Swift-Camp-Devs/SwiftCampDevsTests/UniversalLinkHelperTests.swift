import XCTest
@testable import SwiftCampDevs

class MockAppLauncher: AppLauncherProtocol {
    var openURLCalled = false
    var openSuccess = true

    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?) {
        openURLCalled = true
        completion?(openSuccess)
    }
}
class UniversalLinkHelperTests: XCTestCase {
    
    func test_Open_ValidURL_Success() {
        let mockApp = MockAppLauncher()
        let validURL = "https://www.example.com"
        UniversalLinkHelper.openURL(validURL, application: mockApp)
        XCTAssertTrue(mockApp.openURLCalled, "✅ The URL should have been opened.")
    }
    func test_Open_ValidURL_ButFails_ShouldStillAttemptToOpen() {
        let mockApp = MockAppLauncher()
        mockApp.openSuccess = false
        let validURL = "https://www.example.com"
        UniversalLinkHelper.openURL(validURL, application: mockApp)
        XCTAssertTrue(mockApp.openURLCalled, "🚀 The URL should have been attempted to open.")
    }
}
