import XCTest
@testable import SwiftCampDevs
import UIKit

final class ToastHelperTests: XCTestCase {
    private var toastHelper: ToastHelper!
    private var mockViewController: UIViewController!

    override func setUpWithError() throws {
        LoggerHelper.shared.info("🔹 Setting up ToastHelper test environment...")
        toastHelper = ToastHelper.shared
        mockViewController = UIViewController()
        mockViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        LoggerHelper.shared.info("🔹 Tearing down ToastHelper test environment...")
        toastHelper = nil
        mockViewController = nil
    }

    // MARK: - ✅ Singleton Instance Test
    func testSingletonInstance() {
        LoggerHelper.shared.info("🛠 Testing ToastHelper singleton instance")
        let anotherInstance = ToastHelper.shared
        XCTAssertTrue(toastHelper === anotherInstance, "ToastHelper should be a singleton")
    }

    // MARK: - ✅ Toast View Addition Test
    func testShowToastAddsViewToViewController() {
        LoggerHelper.shared.info("🛠 Testing if Toast is added to the view controller")

        toastHelper.showToast(
            in: mockViewController.view,
            title: "Test Toast",
            type: .success,
            duration: 3.0
        )

        let expectation = self.expectation(description: "Toast should be visible")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let toastView = self.mockViewController.view.subviews.first(where: { $0 is ToastView })
            XCTAssertNotNil(toastView, "ToastView should be added to the view hierarchy")
            LoggerHelper.shared.info("✅ ToastView successfully added to the view")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }

    // MARK: - ✅ Toast Auto-Dismiss Test
    func testToastDisappearsAfterDuration() {
        LoggerHelper.shared.info("🛠 Testing if Toast disappears after duration")

        let expectation = expectation(description: "Toast should disappear after duration")

        toastHelper.showToast(
            in: mockViewController.view,
            title: "Auto Dismiss",
            type: .info,
            duration: 1.0
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let toastView = self.mockViewController.view.subviews.first(where: { $0 is ToastView })
            XCTAssertNil(toastView, "ToastView should be removed after duration")
            LoggerHelper.shared.info("✅ ToastView successfully removed after duration")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3.0)
    }

    // MARK: - ✅ Toast Appearance Test (Background & Text Color)
    func testToastAppearanceMatchesType() {
        LoggerHelper.shared.info("🛠 Testing Toast appearance matches type configuration")

        let type: ToastType = .warning
        toastHelper.showToast(
            in: mockViewController.view,
            title: "Warning Toast",
            type: type,
            duration: 3.0
        )

        let expectation = self.expectation(description: "Toast should be styled correctly")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let toastView = self.mockViewController.view.subviews.first(where: { $0 is ToastView }) as? ToastView else {
                XCTFail("ToastView should exist")
                return
            }

            XCTAssertEqual(toastView.backgroundColor, type.backgroundColor, "Toast background color should match")
            let stackView = toastView.subviews.compactMap { $0 as? UIStackView }.first
            XCTAssertNotNil(stackView, "Toast should contain a stack view")

            let titleLabel = stackView?.arrangedSubviews.compactMap { $0 as? UILabel }.first
            XCTAssertEqual(titleLabel?.textColor, type.textColor, "Toast text color should match")
            LoggerHelper.shared.info("✅ Toast appearance verified")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }

    // MARK: - ✅ Toast Fade-In and Fade-Out Animation Test
    func testToastFadesInAndOut() {
        LoggerHelper.shared.info("🛠 Testing Toast fade-in and fade-out animation")

        toastHelper.showToast(
            in: mockViewController.view,
            title: "Fade Test",
            type: .info,
            duration: 2.0
        )

        let fadeInExpectation = expectation(description: "Toast should fade in")
        let fadeOutExpectation = expectation(description: "Toast should fade out")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let toastView = self.mockViewController.view.subviews.first(where: { $0 is ToastView }) else {
                XCTFail("Toast should exist after 0.5s")
                return
            }
            XCTAssertEqual(toastView.transform, CGAffineTransform(translationX: 0, y: -120), "Toast should be animated in")
            LoggerHelper.shared.info("✅ Toast successfully faded in")
            fadeInExpectation.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let toastView = self.mockViewController.view.subviews.first(where: { $0 is ToastView })
            XCTAssertNil(toastView, "Toast should have faded out and removed")
            LoggerHelper.shared.info("✅ Toast successfully faded out")
            fadeOutExpectation.fulfill()
        }

        wait(for: [fadeInExpectation, fadeOutExpectation], timeout: 3.0)
    }

    // MARK: - ✅ Custom Toast Type Test
    func testCustomToastType() {
        LoggerHelper.shared.info("🛠 Testing custom toast type")

        let customType = ToastType.custom(
            backgroundColor: .purple,
            textColor: .yellow,
            icon: UIImage(systemName: "star.fill")
        )

        toastHelper.showToast(
            in: mockViewController.view,
            title: "Custom Toast",
            type: customType,
            duration: 2.0
        )

        let expectation = self.expectation(description: "Custom toast should apply colors and icon correctly")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let toastView = self.mockViewController.view.subviews.first(where: { $0 is ToastView }) as? ToastView else {
                XCTFail("ToastView should exist")
                return
            }

            XCTAssertEqual(toastView.backgroundColor, customType.backgroundColor, "Background color should match custom type")
            let stackView = toastView.subviews.compactMap { $0 as? UIStackView }.first
            let iconImageView = stackView?.arrangedSubviews.compactMap { $0 as? UIImageView }.first
            XCTAssertEqual(iconImageView?.tintColor, customType.textColor, "Icon color should match custom type")
            XCTAssertEqual(iconImageView?.image?.pngData(), UIImage(systemName: "star.fill")?.pngData(), "Icon image should match custom type")
            LoggerHelper.shared.info("✅ Custom toast verified successfully")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }
}
