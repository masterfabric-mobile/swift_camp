import XCTest
@testable import SwiftCampDevs

final class EnvironmentHelperTests: XCTestCase {
    var sut: EnvironmentHelper!
    override func setUp() {
        super.setUp()
        sut = EnvironmentHelper.shared
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func testEnvironmentType() {
        // Given
        let environment = sut.environment
        // Then
        XCTAssertNotNil(environment)
        XCTAssert([.dev, .uat, .prod].contains(environment))
    }
    func testAPIBaseURL() {
        // When
        let baseURL = sut.apiBaseUrl
        // Then
        XCTAssertFalse(baseURL.isEmpty)
    }
    func testAPIKey() {
        // When
        let apiKey = sut.apiKey
        // Then
        XCTAssertNotNil(apiKey)
        XCTAssertFalse(apiKey.isEmpty)
    }
    func testOneSignalAppID() {
        // When
        let appID = sut.oneSignalAppID
        // Then
        XCTAssertNotNil(appID)
    }
    func testMixPanelToken() {
        // When
        let token = sut.mixPanelToken
        // Then
        XCTAssertNotNil(token)
    }
    func testGitHubRepoAPI() {
        // When
        let apiURL = sut.githubRepoApi
        // Then
        XCTAssertNotNil(apiURL)
        XCTAssertTrue(apiURL.contains("api.github.com"))
    }
    func testEncryptionKey() {
        // When
        let key = sut.encryptionKey
        // Then
        XCTAssertNotNil(key)
        XCTAssertFalse(key.isEmpty)
    }
}
