import XCTest
import AVFoundation
import Contacts
import Photos
import UserNotifications
import Intents
import EventKit
import CoreLocation

@testable import SwiftCampDevs

final class PermissionHelperTests: XCTestCase {

    let permissionHelper = PermissionHelper.shared
    static var permissionResults: [String: String] = [:]
    // 🔔 Notification Permission Test
    func testNotificationPermission() {
        let expectation = XCTestExpectation(description: "🔔 Notification permission check")

        permissionHelper.checkNotificationPermission { granted in
            Self.permissionResults["Notifications"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 📇 Contacts Permission Test
    func testContactsPermission() {
        let expectation = XCTestExpectation(description: "📇 Contacts permission check")

        permissionHelper.checkContactsPermission { granted in
            Self.permissionResults["Contacts"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 🎤 Microphone Permission Test
    func testMicrophonePermission() {
        let expectation = XCTestExpectation(description: "🎤 Microphone permission check")

        permissionHelper.checkMicrophonePermission { granted in
            Self.permissionResults["Microphone"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 🖼️ Photo Library Permission Test
    func testPhotoLibraryPermission() {
        let expectation = XCTestExpectation(description: "🖼️ Photo library permission check")

        permissionHelper.checkPhotoLibraryPermission { granted in
            Self.permissionResults["Photo Library"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 🗣️ Siri Permission Test
    func testSiriPermission() {
        let expectation = XCTestExpectation(description: "🗣️ Siri permission check")

        permissionHelper.checkSiriPermission { granted in
            Self.permissionResults["Siri"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 📍 Location Permission Test
    func testLocationPermission() {
        let expectation = XCTestExpectation(description: "📍 Location permission check")

        permissionHelper.checkLocationPermission { granted in
            Self.permissionResults["Location"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 💾 Storage Permission Test
    func testStoragePermission() {
        let expectation = XCTestExpectation(description: "💾 Storage permission check")

        permissionHelper.checkStoragePermission { granted in
            Self.permissionResults["Storage"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 📂 External Storage (Media Library) Test
    func testExternalStoragePermission() {
        let expectation = XCTestExpectation(description: "📂 External storage permission check")

        permissionHelper.checkExternalStorageAccess { granted in
            Self.permissionResults["External Storage"] = granted ? "✅ Granted" : "❌ Denied"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
        sleep(1)
    }

    // 🏁 **TEST SUMMARY** - 
    override func tearDown() {
        super.tearDown()

        if Self.permissionResults.count == 8 {
            print("\n\n🏁 **TEST SUMMARY** 🏁")
            print("===================================")
            for (permission, result) in Self.permissionResults.sorted(by: { $0.key < $1.key }) {
                print("\(permission): \(result)")
            }
            print("===================================")
            print("✅ All tests completed.\n\n")
        }
    }
}
