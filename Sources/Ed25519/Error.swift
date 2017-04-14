public enum Ed25519Error: Error {
    case seedGenerationFailed
    case invalidPublicKeyLength
    case invalidPrivateKeyLength
    case invalidSignatureLength
}
