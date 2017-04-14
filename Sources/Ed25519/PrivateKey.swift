import CEd25519

public final class PrivateKey {
    let buffer: [UInt8]
    
    public init(_ bytes: [UInt8]) throws {
        guard bytes.count == 64 else {
            throw Ed25519Error.invalidPrivateKeyLength
        }
        
        self.buffer = bytes
    }
    
    init(unchecked buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    public var bytes: [UInt8] {
        return buffer
    }
}
