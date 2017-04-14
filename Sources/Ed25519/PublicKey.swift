import CEd25519

public final class PublicKey {
    let buffer: [UInt8]
    
    public init(_ bytes: [UInt8]) throws {
        guard bytes.count == 32 else {
            throw Ed25519Error.invalidPublicKeyLength
        }
        
        self.buffer = bytes
    }
    
    init(unchecked buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    public var bytes: [UInt8] {
        return buffer
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
