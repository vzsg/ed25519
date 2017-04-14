public enum Ed25519Error: Error {
    case seedGenerationFailed
    case invalidSeedLength
    case invalidPublicKeyLength
    case invalidPrivateKeyLength
    case invalidSignatureLength
}
