# Ed25519 for Swift 4

[![CircleCI](https://circleci.com/gh/vzsg/ed25519.svg?style=shield)](https://circleci.com/gh/vzsg/ed25519)


This project is a Swift adaptation of the portable C [Ed25519](http://ed25519.cr.yp.to/)
implementation available [here](https://github.com/orlp/ed25519).
The complete functionality,
including the key exchange and scalar addition functions are available.

On both macOS and Linux systems, `/dev/urandom` will be used for generating seeds.

Installation
------------

To integrate the library in your SwiftPM project, add the following dependency to Package.swift:

```swift
// swift-tools-version:4.1

.package(url: "https://github.com/AndrewBarba/ed25519.git", from: "1.0.0")
```

API
---

```swift
let seed = try Seed()
```

Creates a 32 byte random seed for key generation.
May throw `Ed25519Error.seedGenerationFailed` in case there was a problem with reading from `/dev/urandom`.

```swift
let seedBytes: [UInt8] = [ ... ]
let seed2 = try Seed(bytes: bytes)
```

Creates a seed for key generation with a previously known value.
`bytes` must be an array of 32 bytes, otherwise `Ed25519Error.invalidSeedLength` will be thrown.

```swift
let keyPair = KeyPair(seed: seed)
```

Creates a new key pair from the given seed.

```swift
let pubBytes: [UInt8] = [ ... ]
let privBytes: [UInt8] = [ ... ]
let keyPair2 = try KeyPair(publicKey: pubBytes, privateKey: privBytes)
```

Creates a key pair from the previously known public and private keys.
Throws `Ed25519Error.invalidPublicKeyLength` if the public key is not 32,
or `Ed25519Error.invalidPrivateKeyLength` if the private key is not 64 bytes long.

```swift
let publicKey = try PublicKey(pubBytes)
let privateKey = try PrivateKey(privBytes)
let keyPair3 = KeyPair(publicKey: publicKey, privateKey: privateKey)
```

Construct public and private keys directly.
The same length limitations and exceptions apply.

```swift
publicKey.bytes
privateKey.bytes
keyPair.publicKey.bytes
keyPair.privateKey.bytes
seed.bytes
```

Access raw byte arrays behind any key or seed with the `bytes` property.

```swift
let message: [UInt8] = [ ... ]
let signature: [UInt8] = keyPair.sign(message: message)
```

Creates a signature of the given message with the given key pair.
`signature` will be an array of 64 bytes.

```swift
let valid: Bool = try keyPair.verify(signature: signature, message: message)
let valid2: Bool = try publicKey.verify(signature: signature, message: message)
```

Verifies the signature on the given message using a key pair or a public key.
Both methods throw `Ed25519Error.invalidSignatureLength` if `signature` is not an array of 64 bytes.

```swift
let scalar: [UInt8] = [ ... ]
let keyPairMod = try keyPair.add(scalar: scalar)
let publicKeyMod = try publicKey.add(scalar: scalar)
let privateKeyMod = try privateKey.add(scalar: scalar)
```

Adds `scalar` to the given key pair, public or private key, where scalar is a 32 byte buffer (possibly
generated with a seed), generating new key(s). This is useful for enforcing
randomness on a key pair by a third party while only knowing the public key,
among other things.  Warning: the last bit of the scalar is ignored - if
comparing scalars make sure to ignore `scalar[31]`.

```swift
let sharedSecret = keyPair.keyExchange()
let sharedSecret2 = try KeyPair.keyExchange(publicKey: pubBytes, privateKey: privBytes)
let sharedSecret3 = KeyPair.keyExchange(publicKey: publicKey, privateKey: privateKey)
```

Performs a key exchange on the given public key and private key, producing a
shared secret, an array of 32 bytes. It is recommended to hash the shared secret before using it.

Example
-------

Check the unit tests for usage examples.

License
-------

The Swift library is released under the MIT license. See LICENSE for details.

The C implementation is (c) 2015 Orson Peters, licensed under the permissive zlib license.
The original source code is not modified, only reorganized for SwiftPM consumption.
See license.txt in CEd25519 for details.
