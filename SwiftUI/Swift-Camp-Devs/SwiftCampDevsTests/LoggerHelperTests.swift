import XCTest
import SwiftyBeaver
@testable import SwiftCampDevs

final class LoggerHelperTests: XCTestCase {
    var sut: LoggerHelper!
    
    override func setUp() {
        super.setUp()
        sut = LoggerHelper.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Singleton Tests
    func testSharedInstance() {
        let instance1 = LoggerHelper.shared
        let instance2 = LoggerHelper.shared
        
        XCTAssertTrue(instance1 === instance2, "Should return same instance")
    }
    
    // MARK: - Logging Methods Tests
    func testInfoLogging() {
        // When
        sut.info("Test info message")
        // Then - Verify no crashes
    }
    
    func testDebugLogging() {
        // When
        sut.debug("Test debug message")
        // Then - Verify no crashes
    }
    
    func testWarningLogging() {
        // When
        sut.warning("Test warning message")
        // Then - Verify no crashes
    }
    
    func testErrorLogging() {
        // When
        sut.error("Test error message")
        // Then - Verify no crashes
    }
    
    func testVerboseLogging() {
        // When
        sut.verbose("Test verbose message")
        // Then - Verify no crashes
    }
    
    // MARK: - Custom Destination Test
    func testCustomDestination() {
        // Create a mock destination
        class MockDestination: BaseDestination {
            var lastMessage: String?
            
            override func send(_ level: SwiftyBeaver.Level, msg: String, thread: String,
                             file: String, function: String, line: Int, context: Any?) -> String? {
                lastMessage = msg
                return msg
            }
        }
        
        // Given
        let mockDestination = MockDestination()
        SwiftyBeaver.addDestination(mockDestination)
        
        // When
        let testMessage = "Test message"
        sut.info(testMessage)
        
        // Then
        XCTAssertTrue(mockDestination.lastMessage?.contains(testMessage) ?? false)
        
        // Cleanup
        SwiftyBeaver.removeDestination(mockDestination)
    }
}
