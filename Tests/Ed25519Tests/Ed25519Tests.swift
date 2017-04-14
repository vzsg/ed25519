import XCTest
@testable import Ed25519

class Ed25519Tests: XCTestCase {
    func testSeed() throws {
        let seed = try Seed()
        XCTAssertEqual(32, seed.bytes.count)
        XCTAssertNotEqual([UInt8](repeating: 0, count: 32), seed.bytes)
    }
    
    
    func testSignAndVerify() throws {
        let seed = try Seed()
        let keyPair = KeyPair(seed: seed)
        let message = [UInt8]("Hello World!".utf8)
        let otherMessage = [UInt8]("Bonan tagon!".utf8)
        let signature = keyPair.sign(message)
        var tamperedSignature = signature
        
        tamperedSignature[3] = tamperedSignature[3] &+ 1
        XCTAssertTrue(try keyPair.verify(signature: signature, message: message))
        XCTAssertFalse(try keyPair.verify(signature: signature, message: otherMessage))
        XCTAssertFalse(try keyPair.verify(signature: tamperedSignature, message: message))
        XCTAssertFalse(try keyPair.verify(signature: signature, message: []))
        XCTAssertThrowsError(try keyPair.verify(signature: [1,2,3], message: message))
    }

    func testKeyExchange() throws {
        let keyPair = KeyPair(seed: try Seed())
        let otherKeyPair = KeyPair(seed: try Seed())
        
        XCTAssertNotEqual(keyPair.privateKey.bytes, otherKeyPair.privateKey.bytes)
        XCTAssertNotEqual(keyPair.publicKey.bytes, otherKeyPair.publicKey.bytes)
        
        let secret1 = try KeyPair.keyExchange(publicKey: keyPair.publicKey.bytes,
                                              privateKey: otherKeyPair.privateKey.bytes)
        let secret2 = try KeyPair.keyExchange(publicKey: otherKeyPair.publicKey.bytes,
                                              privateKey: keyPair.privateKey.bytes)
        XCTAssertEqual(secret1, secret2)
    }

    static var allTests = [
        ("testSeed", testSeed),
        ("testSignAndVerify", testSignAndVerify),
        ("testKeyExchange", testKeyExchange)
    ]
}
