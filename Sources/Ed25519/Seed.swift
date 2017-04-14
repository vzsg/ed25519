import CEd25519

public class Seed {
    let buffer: [UInt8]
    
    public init() throws {
        buffer = [UInt8](repeating: 0, count: 32)
        
        let result = buffer.withUnsafeMutableBufferPointer {
            ed25519_create_seed($0.baseAddress)
        }
        
        guard result == 0 else {
            throw Ed25519Error.seedGenerationFailed
        }
    }
}
