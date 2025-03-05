import XCTest
@testable import SwiftCampDevs

class SnackbarHelperTests: XCTestCase {
    var snackbarHelper: SnackbarHelper!
    var mockViewController: UIViewController!

    override func setUpWithError() throws {
        LoggerHelper.shared.info("🔹 Setting up test environment...")
        snackbarHelper = SnackbarHelper.shared
        mockViewController = UIViewController()
        mockViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        LoggerHelper.shared.info("🔹 Tearing down test environment...")
        snackbarHelper = nil
        mockViewController = nil
    }

    // MARK: - ✅ Singleton Instance Test
    func testSingletonInstance() {
        LoggerHelper.shared.info("🛠 Testing singleton instance for SnackbarHelper")
        let anotherInstance = SnackbarHelper.shared
        XCTAssertTrue(snackbarHelper === anotherInstance, "SnackbarHelper should be a singleton")
    }

    // MARK: - ✅ Snackbar View Addition Test
    func testShowSnackbarAddsViewToViewController() {
        LoggerHelper.shared.info("🛠 Testing if Snackbar is added to the view controller")
        snackbarHelper.showSnackbar(
            in: mockViewController,
            type: .success,
            title: "Success",
            description: "Operation completed successfully",
            duration: 3.0
        )

        let expectation = self.expectation(description: "Snackbar should be visible")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let hasSnackbar = self.mockViewController.view.subviews.contains { $0 is UIView }
            XCTAssertTrue(hasSnackbar, "Snackbar should be added to the view hierarchy")
            LoggerHelper.shared.info("✅ Snackbar successfully added to the view")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }

    // MARK: - ✅ Snackbar Auto-Dismiss Test
    func testSnackbarDisappearsAfterDuration() {
        LoggerHelper.shared.info("🛠 Testing if Snackbar disappears after duration")

        let expectation = expectation(description: "Snackbar should disappear after duration")

        snackbarHelper.showSnackbar(
            in: mockViewController,
            type: .success,
            title: "Success",
            description: "This will disappear",
            duration: 2.0
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let hasSnackbar = self.mockViewController.view.subviews.contains { $0 is UIView }
            XCTAssertFalse(hasSnackbar, "Snackbar should be removed after duration")
            LoggerHelper.shared.info("✅ Snackbar successfully removed after duration")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 4.0)
    }

    // MARK: - ✅ Snackbar Fade-In and Fade-Out Animation Test
    func testSnackbarFadesInAndOut() {
        LoggerHelper.shared.info("🛠 Testing Snackbar fade-in and fade-out animation")

        let expectation = self.expectation(description: "Snackbar should fade in and out")

        snackbarHelper.showSnackbar(
            in: mockViewController,
            type: .info,
            title: "Info",
            description: "Testing fade in and out",
            duration: 3.0
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let snackbarView = self.mockViewController.view.subviews.first(where: { $0 is UIView }) else {
                LoggerHelper.shared.error("❌ Snackbar not found in UI at 0.5s")
                XCTFail("Snackbar should exist at 0.5s")
                return
            }
            XCTAssertEqual(snackbarView.alpha, 1, "Snackbar should fade in")
            LoggerHelper.shared.info("✅ Snackbar successfully faded in")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            let snackbarView = self.mockViewController.view.subviews.first(where: { $0 is UIView })
            if snackbarView == nil {
                LoggerHelper.shared.warning("⚠️ Snackbar removed before checking fade-out animation")
            } else {
                XCTAssertEqual(snackbarView?.alpha, 0, "Snackbar should fade out before disappearing")
                LoggerHelper.shared.info("✅ Snackbar successfully faded out")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 4.0)
    }

    // MARK: - ✅ Long Title and Description Wrapping Test
    func testSnackbarHandlesLongText() {
        LoggerHelper.shared.info("🛠 Testing Snackbar text wrapping for long title and description")

        snackbarHelper.showSnackbar(
            in: mockViewController,
            type: .warning,
            title: "A very long title that might overflow and should wrap correctly",
            description: "This is a very long description that should wrap across multiple lines to ensure Snackbar can handle multiline text properly.",
            duration: 3.0
        )

        let expectation = self.expectation(description: "Snackbar should handle long text")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.mockViewController.view.layoutIfNeeded()

            let snackbarView = self.mockViewController.view.viewWithTag(999)
            XCTAssertNotNil(snackbarView, "Snackbar view was not added to the view hierarchy.")
            LoggerHelper.shared.info("✅ Snackbar view found in the UI")

            let titleLabel = snackbarView?.subviews.compactMap { $0 as? UILabel }.first
            XCTAssertNotNil(titleLabel, "Snackbar does not contain a title label.")
            LoggerHelper.shared.info("✅ Snackbar title label found")

            guard let titleLabel = titleLabel else {
                expectation.fulfill()
                return
            }

            XCTAssertGreaterThan(titleLabel.intrinsicContentSize.height, 30, "Title label should have a multi-line height")
            LoggerHelper.shared.info("✅ Snackbar title label successfully wrapped to multiple lines")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }

    // MARK: - ✅ Handling Nil Description Test
    func testSnackbarHandlesNilDescription() {
        LoggerHelper.shared.info("🛠 Testing Snackbar behavior when description is nil")

        snackbarHelper.showSnackbar(
            in: mockViewController,
            type: .error,
            title: "Error",
            description: nil,
            duration: 3.0
        )

        let expectation = self.expectation(description: "Snackbar should handle nil description")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.mockViewController.view.layoutIfNeeded()

            let snackbarView = self.mockViewController.view.viewWithTag(999)
            XCTAssertNotNil(snackbarView, "Snackbar should be added to the view hierarchy.")
            LoggerHelper.shared.info("✅ Snackbar added to UI without description")

            let labels = snackbarView?.subviews.compactMap { $0 as? UILabel }
            XCTAssertNotNil(labels, "Snackbar should contain at least one label.")
            XCTAssertEqual(labels?.count, 1, "Only title label should exist when description is nil")
            LoggerHelper.shared.info("✅ Snackbar correctly displayed without description")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }
}
