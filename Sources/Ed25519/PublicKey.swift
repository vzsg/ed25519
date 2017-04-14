import CEd25519

public final class PublicKey {
    public static let length = 32

    let buffer: [UInt8]
    
    public init(_ buffer: [UInt8]) throws {
        guard buffer.count == PublicKey.length else {
            throw Ed25519Error.invalidPublicKeyLength
        }
        
        self.buffer = buffer
    }
    
    init(unchecked buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    public func verify(signature: [UInt8], message: [UInt8]) throws -> Bool {
        guard signature.count == 64 else {
            throw Ed25519Error.invalidSignatureLength
        }

        return signature.withUnsafeBufferPointer { signature in
            message.withUnsafeBufferPointer { msg in
                buffer.withUnsafeBufferPointer { pub in
                    ed25519_verify(signature.baseAddress,
                                   msg.baseAddress,
                                   message.count,
                                   pub.baseAddress) == 1
                }
            }
        }
    }
}
