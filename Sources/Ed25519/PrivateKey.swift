import CEd25519

public final class PrivateKey {
    let buffer: [UInt8]
    
    public init(_ buffer: [UInt8]) throws {
        guard buffer.count == 64 else {
            throw Ed25519Error.invalidPrivateKeyLength
        }
        
        self.buffer = buffer
    }
    
    init(unchecked buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    public var bytes: [UInt8] {
        return buffer
    }
}
