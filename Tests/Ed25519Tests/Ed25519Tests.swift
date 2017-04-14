import XCTest
@testable import Ed25519

class Ed25519Tests: XCTestCase {
    func testSeed() throws {
        let seed = try Seed()
        XCTAssertNotEqual([UInt8](repeating: 0, count: 32), seed.buffer)
    }
    
    static var allTests = [
        ("testSeed", testSeed),
    ]
}
