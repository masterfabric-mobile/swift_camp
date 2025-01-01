import Foundation

// MARK: - TimeHelper
final class TimeHelper {
    // MARK: - Shared Instance
    static let shared = TimeHelper()

    // MARK: - Date Formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    // MARK: - Initialization
    private init() {}

    // MARK: - Time Methods

    /// Returns the current date and time as a formatted string.
    func getCurrentDateTime(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }

    /// Returns the current date as a formatted string.
    func getCurrentDate(format: String = "yyyy-MM-dd", timeZone: TimeZone = .current) -> String {
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }

    /// Returns the current time as a formatted string.
    func getCurrentTime(format: String = "HH:mm:ss", timeZone: TimeZone = .current) -> String {
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }

    /// Adds days to the given date.
    func addDays(to date: Date, days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    }

    /// Subtracts days from the given date.
    func subtractDays(from date: Date, days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: date) ?? date
    }

    /// Converts a given date to a formatted string.
    func formatDate(_ date: Date, format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    /// Converts a formatted date string to a Date object.
    func parseDate(_ dateString: String, format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> Date? {
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }

    /// Checks if a given date is today.
    func isToday(_ date: Date, timeZone: TimeZone = .current) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        return calendar.isDateInToday(date)
    }

    /// Checks if a given date is tomorrow.
    func isTomorrow(_ date: Date, timeZone: TimeZone = .current) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        return calendar.isDateInTomorrow(date)
    }

    /// Checks if a given date is in the past.
    func isPastDate(_ date: Date) -> Bool {
        date < Date()
    }

    /// Calculates the elapsed time between two dates.
    func getElapsedTime(from startDate: Date, to endDate: Date = Date()) -> String {
        let elapsed = endDate.timeIntervalSince(startDate)
        let hours = Int(elapsed) / 3600
        let minutes = (Int(elapsed) % 3600) / 60
        let seconds = Int(elapsed) % 60
        return "\(hours)h \(minutes)m \(seconds)s"
    }
}
