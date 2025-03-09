import XCTest
@testable import SwiftCampDevs

class NetworkHelperTests: XCTestCase {
    var networkHelper: NetworkHelper!
    
    override func setUp() {
        super.setUp()
        networkHelper = NetworkHelper.shared
    }
    
    override func tearDown() {
        networkHelper = nil
        super.tearDown()
    }
    
    // MARK: - Connection Status and Type Tests
    
    func testIsConnectedToNetwork() {
        let isConnected = networkHelper.isConnectedToNetwork()
        XCTAssertNotNil(isConnected)
    }
    
    func testGetNetworkType() {
        let networkType = networkHelper.getNetworkType()
        XCTAssertTrue(["WiFi", "Cellular", "Unknown"].contains(networkType))
    }
    
    func testCheckNetworkProtocol() {
        let networkProtocol = networkHelper.checkNetworkProtocol()
        XCTAssertTrue(["IPv4", "IPv6", "Unknown"].contains(networkProtocol))
    }
    
    // MARK: - Speed and Performance Tests
    
    func testMeasureDownloadSpeed() {
        let expectation = self.expectation(description: "Download Speed Measured")
        networkHelper.measureDownloadSpeed { speed in
            XCTAssertGreaterThanOrEqual(speed, 0.0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMeasureUploadSpeed() {
        let expectation = self.expectation(description: "Upload Speed Measured")
        networkHelper.measureUploadSpeed { speed in
            XCTAssertGreaterThanOrEqual(speed, 0.0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMeasurePing() {
        let expectation = self.expectation(description: "Ping Measured")
        networkHelper.measurePing { ping in
            XCTAssertGreaterThanOrEqual(ping, 0.0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMeasureJitter() {
        let expectation = self.expectation(description: "Jitter Measured")
        let samplePingValues = [10.0, 15.0, 20.0, 25.0]
        networkHelper.measureJitter(pingValues: samplePingValues) { jitter in
            XCTAssertGreaterThanOrEqual(jitter, 0.0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: - Network Information Tests
    
    func testFetchCloudflareInfo() {
        let expectation = self.expectation(description: "Cloudflare Info Fetched")
        networkHelper.fetchCloudflareInfo { info in
            XCTAssertNotNil(info)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testIsVPNConnected() {
        let isVPNActive = networkHelper.isVPNConnected()
        XCTAssertNotNil(isVPNActive)
    }
    
    func testFetchPublicIPAddress() {
        let expectation = self.expectation(description: "Public IP Address Fetched")
        networkHelper.fetchPublicIPAddress { ip in
            XCTAssertNotNil(ip)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: - Check Network Health Tests
        
        func testCheckNetworkHealth_HighPing() {
            networkHelper.checkNetworkHealth(ping: 150, downloadSpeed: 50, uploadSpeed: 10)
            XCTAssertEqual(networkHelper.connectionIssue, "Ping is too high")
        }
        
        func testCheckNetworkHealth_LowDownloadSpeed() {
            networkHelper.checkNetworkHealth(ping: 50, downloadSpeed: 5, uploadSpeed: 10)
            XCTAssertEqual(networkHelper.connectionIssue, "Download speed is too low")
        }
        
        func testCheckNetworkHealth_LowUploadSpeed() {
            networkHelper.checkNetworkHealth(ping: 50, downloadSpeed: 50, uploadSpeed: 2)
            XCTAssertEqual(networkHelper.connectionIssue, "Upload speed is too low")
        }

        // MARK: - DNS Performance Test
        
        func testMeasureDNSPerformance() {
            let expectation = self.expectation(description: "DNS resolution should complete")

            networkHelper.measureDNSPerformance { responseTime in
                XCTAssertGreaterThan(responseTime, 0, "DNS response time should be greater than zero")
                expectation.fulfill()
            }

            waitForExpectations(timeout: 5, handler: nil)
        }
}
