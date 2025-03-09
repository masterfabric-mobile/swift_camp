import XCTest
@testable import SwiftCampDevs

final class TimeHelperTests: XCTestCase {
    var timeHelper: TimeHelper!
    override func setUp() {
        super.setUp()
        timeHelper = TimeHelper.shared
    }
    override func tearDown() {
        timeHelper = nil
        super.tearDown()
    }
    // MARK: - Date and Time Formatting Tests
    func testGetCurrentDateTime() {
        let formattedDateTime = timeHelper.getCurrentDateTime(format: "yyyy-MM-dd HH:mm:ss")
        XCTAssertEqual(formattedDateTime.count, 19)
    }
    func testGetCurrentDate() {
        let formattedDate = timeHelper.getCurrentDate(format: "yyyy-MM-dd")
        XCTAssertEqual(formattedDate.count, 10)
    }
    func testGetCurrentTime() {
        let formattedTime = timeHelper.getCurrentTime(format: "HH:mm:ss")
        XCTAssertEqual(formattedTime.count, 8)
    }
    // MARK: - Date Manipulation Tests
    func testAddDays() {
        let today = Date()
        let futureDate = timeHelper.addDays(to: today, days: 5)
        let expectedDate = Calendar.current.date(byAdding: .day, value: 5, to: today)
        XCTAssertEqual(futureDate, expectedDate)
    }
    func testSubtractDays() {
        let today = Date()
        let pastDate = timeHelper.subtractDays(from: today, days: 3)
        let expectedDate = Calendar.current.date(byAdding: .day, value: -3, to: today)
        XCTAssertEqual(pastDate, expectedDate)
    }
    func testFormatDate() {
        let date = Date(timeIntervalSince1970: 0)
        let formattedDate = timeHelper.formatDate(date, format: "yyyy-MM-dd")
        XCTAssertEqual(formattedDate, "1970-01-01")
    }
    func testParseDate() {
        let dateString = "2025-02-24 15:30:00"
        let parsedDate = timeHelper.parseDate(dateString, format: "yyyy-MM-dd HH:mm:ss")
        XCTAssertNotNil(parsedDate)
    }
    func testParseInvalidDate() {
        let invalidDateString = "2025-02-31 15:30:00"
        let parsedDate = timeHelper.parseDate(invalidDateString, format: "yyyy-MM-dd HH:mm:ss")
        XCTAssertNil(parsedDate)
    }
    // MARK: - Date Comparison Tests
    
    func testIsToday() {
        let today = Date()
        XCTAssertTrue(timeHelper.isToday(today))
    }
    func testIsTomorrow() {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        XCTAssertTrue(timeHelper.isTomorrow(tomorrow))
    }
    func testIsPastDate() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        XCTAssertTrue(timeHelper.isPastDate(pastDate))
    }
    // MARK: - Time Calculation Tests
    func testGetElapsedTime() {
        let pastDate = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
        let elapsedTime = timeHelper.getElapsedTime(from: pastDate)
        XCTAssertTrue(elapsedTime.contains("1h"))
    }
    func testOTPCounter() {
        let remainingTime = timeHelper.getOTPCounter(interval: 30)
        XCTAssertTrue(remainingTime >= 0 && remainingTime <= 30)
    }
    // MARK: - TimeZone Tests
    func testGetCurrentDateTimeWithTimeZone() {
        let timeZone = TimeZone(identifier: "UTC")!
        let formattedDateTime = timeHelper.getCurrentDateTime(format: "yyyy-MM-dd HH:mm:ss", timeZone: timeZone)
        XCTAssertTrue(formattedDateTime.contains("2025-02-27"))
    }
    func testGetCurrentDateWithTimeZone() {
        let timeZone = TimeZone(identifier: "UTC")!
        let formattedDate = timeHelper.getCurrentDate(format: "yyyy-MM-dd", timeZone: timeZone)
        XCTAssertTrue(formattedDate.contains("2025-02-27"))
    }
    func testGetCurrentDateTime_UTC() {
        let timeZone = TimeZone(identifier: "UTC")!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateTime = timeHelper.getCurrentDateTime(format: "yyyy-MM-dd HH:mm:ss", timeZone: timeZone)
        let expectedDateTime = dateFormatter.string(from: Date())
        XCTAssertEqual(formattedDateTime, expectedDateTime)
    }
    func testGetCurrentTime_UTC() {
        let timeZone = TimeZone(identifier: "UTC")!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HH:mm:ss"
        let formattedTime = timeHelper.getCurrentTime(format: "HH:mm:ss", timeZone: timeZone)
        let expectedTime = dateFormatter.string(from: Date())
        XCTAssertEqual(formattedTime, expectedTime)
    }
}
