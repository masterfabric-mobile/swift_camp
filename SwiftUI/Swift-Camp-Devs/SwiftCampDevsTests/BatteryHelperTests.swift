import XCTest
import SwiftUI
@testable import SwiftCampDevs

final class BatteryHelperTests: XCTestCase {
    
    var batteryHelper: BatteryHelper!
    
    override func setUp() {
        super.setUp()
        batteryHelper = BatteryHelper.shared
        print("Setup: BatteryHelper instance initialized.")
    }
    
    override func tearDown() {
        batteryHelper.stopSimulation()
        batteryHelper = nil
        print("Teardown: BatteryHelper instance cleaned up.")
        super.tearDown()
    }
    
    /// Test that battery level is updated between 0 and 100.
    func testBatteryLevelUpdate() {
        print("Starting testBatteryLevelUpdate...")
        batteryHelper.updateBatteryInfo()
        let level = batteryHelper.batteryLevel
        print("Battery level after update: \(level)%")
        XCTAssertGreaterThanOrEqual(level, 0, "Battery level should not be negative.")
        XCTAssertLessThanOrEqual(level, 100, "Battery level should not exceed 100.")
        print("Finished testBatteryLevelUpdate.\n")
    }
    
    /// Test that battery state description is one of the expected strings.
    func testBatteryStateDescription() {
        print("Starting testBatteryStateDescription...")
        batteryHelper.updateBatteryInfo()
        let stateDescription = batteryHelper.batteryStateDescription
        print("Battery state description after update: \(stateDescription)")
        let validStates = ["Unplugged", "Charging", "Full", "Unknown"]
        XCTAssertTrue(validStates.contains(stateDescription), "Battery state description should be valid.")
        print("Finished testBatteryStateDescription.\n")
    }
    
    /// Test that the battery color is one of the expected colors.
    func testBatteryColor() {
        print("Starting testBatteryColor...")
        batteryHelper.updateBatteryInfo()
        let color = batteryHelper.batteryColor
        print("Battery color after update: \(color)")
        let validColors: [Color] = [.red, .blue, .yellow, .green, .gray]
        // Karşılaştırmada Color'ların açıklamalarını kullanıyoruz
        let isValid = validColors.contains(where: { $0.description == color.description })
        XCTAssertTrue(isValid, "Battery color should be valid.")
        print("Finished testBatteryColor.\n")
    }
    
    /// Test that simulated battery updates change the battery level over time.
    func testSimulatedBatteryUpdate() {
        print("Starting testSimulatedBatteryUpdate...")
        batteryHelper.startSimulationIfNeeded()
        batteryHelper.updateBatteryInfo()
        let initialLevel = batteryHelper.batteryLevel
        print("Initial simulated battery level: \(initialLevel)%")
        
        // Beklemek için expectation kullanıyoruz
        let expectation = self.expectation(description: "Wait for simulation update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
            guard let self = self else { return }
            self.batteryHelper.updateBatteryInfo()
            let updatedLevel = self.batteryHelper.batteryLevel
            print("Updated simulated battery level: \(updatedLevel)%")
            XCTAssertNotEqual(initialLevel, updatedLevel, "Simulated battery level should change over time.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 7)
        print("Finished testSimulatedBatteryUpdate.\n")
    }
    
    /// Test that a low battery level produces a red color.
    func testBatteryColorForLowLevel() {
        print("Starting testBatteryColorForLowLevel...")
        // Manually simulating low battery level.
        batteryHelper.batteryLevel = 5
        let color = batteryHelper.getBatteryStateColor()
        print("Battery color for battery level 5: \(color)")
        XCTAssertEqual(color.description, Color.red.description, "Battery color should be red for low battery level.")
        print("Finished testBatteryColorForLowLevel.\n")
    }
}
