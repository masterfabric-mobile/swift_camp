import XCTest
import FirebaseAuth
@testable import SwiftCampDevs
final class SocialSignInHelperTests: XCTestCase {
    var helper: SocialSignInHelper!
    var logMessages: [String] = []
    var googleTestPassed: Bool = false
    var facebookTestPassed: Bool = false

    override func setUp() {
        super.setUp()
        helper = SocialSignInHelper()
        logMessages = []
        log("🛠️ [Setup] SocialSignInHelper initialized.")
    }

    override func tearDown() {
        log("🧹 [Teardown] Cleaning up SocialSignInHelper...")
        printFinalLog()
        helper = nil
        super.tearDown()
    }

    // ✅ Google Sign-In Test
    func testGoogleSignIn() {
        let expectation = expectation(description: "⌛ Waiting for Google Sign-In...")

        log("🔵 [Test] Google Sign-In is starting...")

        helper.signInWithGoogle { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    XCTAssertNotNil(user, "❌ User information should not be empty.")
                    self.googleTestPassed = true
                    self.log("✅ [Success] Google Sign-In succeeded: \(user.email ?? "Unknown Email")")
                case .failure(let error):
                    self.googleTestPassed = false
                    self.log("❌ [Failure] Google Sign-In failed: \(error.localizedDescription)")
                    XCTFail("❌ Google Sign-In should not fail!")
                }
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 60)
    }

    // ✅ Facebook Sign-In Test
    func testFacebookSignIn() {
        let expectation = expectation(description: "⌛ Waiting for Facebook Sign-In...")

        log("🟦 [Test] Facebook Sign-In is starting...")

        helper.signInWithFacebook { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    XCTAssertNotNil(user, "❌ User information should not be empty.")
                    self.facebookTestPassed = true
                    self.log("✅ [Success] Facebook Sign-In succeeded: \(user.email ?? "Unknown Email")")
                case .failure(let error):
                    self.facebookTestPassed = false
                    self.log("❌ [Failure] Facebook Sign-In failed: \(error.localizedDescription)")
                    XCTFail("❌ Facebook Sign-In should not fail!")
                }
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 60)
    }
    private func log(_ message: String) {
        logMessages.append(message)
        print(message)
    }
    private func printFinalLog() {
        print("\n📜 ====== TEST SUMMARY ======")
        for message in logMessages {
            print(message)
        }
        print("\n📊 TEST RESULTS:")
        print("🔹 Google Sign-In: \(googleTestPassed ? "✅ Passed" : "❌ Failed")")
        print("🔹 Facebook Sign-In: \(facebookTestPassed ? "✅ Passed" : "❌ Failed")")

        if googleTestPassed && facebookTestPassed {
            print("\n🎉 ALL TESTS PASSED SUCCESSFULLY! ✅")
        } else {
            print("\n⚠️ SOME TESTS FAILED! ❌")
        }
        print("\n📜 ====== END OF TEST ======\n")
    }
}
