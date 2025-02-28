import XCTest
import SwiftUI
@testable import SwiftCampDevs

final class ThemeHelperTests: XCTestCase {
    var sut: ThemeHelper!
    override func setUp() {
        super.setUp()
        // Reset UserDefaults for testing
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
        UserDefaults.standard.synchronize()
        // Create a fresh instance of ThemeHelper
        sut = ThemeHelper.shared
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    // MARK: - Initialization Tests
    func testInitialThemeIsLight() {
        // Given
        // Reset any existing theme in UserDefaults
        UserDefaults.standard.removeObject(forKey: "selectedTheme")
        UserDefaults.standard.synchronize()
        // When
        let newThemeHelper = ThemeHelper.shared
        // Then
        XCTAssertEqual(newThemeHelper.themeType, .light, "Initial theme should be light when no theme is saved")
    }
    func testThemeTypeIsSavedToUserDefaults() {
        // Given
        UserDefaults.standard.removeObject(forKey: "selectedTheme")
        UserDefaults.standard.synchronize()
        // When
        sut.applyTheme(.dark)
        // Then
        let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme")
        XCTAssertEqual(savedTheme, ThemeType.dark.rawValue, "Theme should be saved as 'dark' in UserDefaults")
        XCTAssertEqual(sut.themeType, .dark, "ThemeHelper's themeType should be .dark")
    }
    // MARK: - Theme Application Tests
    func testApplyDarkTheme() {
        // When
        sut.applyTheme(.dark)
        // Then
        XCTAssertEqual(sut.themeType, .dark)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                XCTAssertEqual(window.overrideUserInterfaceStyle, .dark)
            }
        }
    }
    func testApplyLightTheme() {
        // When
        sut.applyTheme(.light)
        // Then
        XCTAssertEqual(sut.themeType, .light)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                XCTAssertEqual(window.overrideUserInterfaceStyle, .light)
            }
        }
    }
    // MARK: - Custom Theme Tests
    func testLoadCustomTheme() {
        // Given
        let mockCustomTheme = CustomTheme(
            black: "#000000",
            white: "#FFFFFF",
            darkGray: "#333333",
            softGray: "#666666",
            lightGray: "#999999",
            powderBlue: "#B0E0E6",
            blue: "#0000FF",
            successColor: "#00FF00",
            warningColor: "#FF0000"
        )
        // Create a temporary JSON file with mock theme
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("CustomTheme.json")
        let encoder = JSONEncoder()
        try? encoder.encode(mockCustomTheme).write(to: tempURL)
        // When
        sut.applyTheme(.custom)
        // Then
        XCTAssertEqual(sut.themeType, .custom)
        XCTAssertNotNil(sut.customTheme)
    }
    // MARK: - Color Tests
    func testColorForLightTheme() {
        // Given
        sut.applyTheme(.light)
        // When
        let blackColor = sut.color(for: .black)
        let blueColor = sut.color(for: .blue)
        // Then
        XCTAssertEqual(blackColor, AppColors.black)
        XCTAssertEqual(blueColor, AppColors.blue)
    }
    func testColorForDarkTheme() {
        // Given
        sut.applyTheme(.dark)
        // When
        let whiteColor = sut.color(for: .white)
        let successColor = sut.color(for: .successColor)
        // Then
        XCTAssertEqual(whiteColor, AppColors.white)
        XCTAssertEqual(successColor, AppColors.successColor)
    }
    func testColorForCustomTheme() {
        // Given
        let mockCustomTheme = CustomTheme(
            black: "#9B4DCA", // Purple color instead of black
            white: "#FFFFFF",
            darkGray: "#333333",
            softGray: "#666666",
            lightGray: "#999999",
            powderBlue: "#B0E0E6",
            blue: "#0000FF",
            successColor: "#00FF00",
            warningColor: "#FF0000"
        )
        sut.customTheme = mockCustomTheme
        sut.applyTheme(.custom)
        // When
        let purpleColor = sut.color(for: .black) // This will return purple color
        // Then
        let expectedColor = Color(UIColor(hex: "#9B4DCA"))
        // Convert both colors to CGColor components for accurate comparison
        let purpleUIColor = UIColor(purpleColor)
        let expectedUIColor = UIColor(expectedColor)
        let purpleComponents = purpleUIColor.cgColor.components ?? []
        let expectedComponents = expectedUIColor.cgColor.components ?? []
        // Compare each component with a small tolerance
        XCTAssertEqual(purpleComponents.count, expectedComponents.count, "Color components count should match")
        for (index, component) in purpleComponents.enumerated() {
            XCTAssertEqual(component, expectedComponents[index], accuracy: 0.01, "Color component at index \(index) should match")
        }
    }
    // MARK: - UIColor Hex Tests
    func testUIColorHexInitialization() {
        // Test 6-digit hex
        let color1 = UIColor(hex: "#FF0000")
        XCTAssertEqual(color1.cgColor.components?[0], 1.0) // Red
        XCTAssertEqual(color1.cgColor.components?[1], 0.0) // Green
        XCTAssertEqual(color1.cgColor.components?[2], 0.0) // Blue
        // Test 3-digit hex
        let color2 = UIColor(hex: "#F00")
        XCTAssertEqual(color2.cgColor.components?[0], 1.0) // Red
        XCTAssertEqual(color2.cgColor.components?[1], 0.0) // Green
        XCTAssertEqual(color2.cgColor.components?[2], 0.0) // Blue
        // Test invalid hex
        let color3 = UIColor(hex: "invalid")
        XCTAssertEqual(color3.cgColor.components?[0], 0.0) // Default to black
        XCTAssertEqual(color3.cgColor.components?[1], 0.0)
        XCTAssertEqual(color3.cgColor.components?[2], 0.0)
    }
}
