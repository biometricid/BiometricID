# BiometricID SDK

Biometric face recognition SDK for iOS. Uses the TrueDepth IR camera for on-device embedding generation with CoreML. Dual-modal score fusion (IR + RGB) delivers high accuracy while keeping all images on-device — only compact embeddings are sent to the server.

## Features

- **On-device ML** — CoreML inference on the Neural Engine, no cloud processing of images
- **Dual-modal fusion** — IR (70%) + RGB (30%) score fusion for robust recognition
- **Privacy-first** — photos never leave the device; only encrypted embeddings are transmitted
- **ECIES encryption** — biometric embeddings are encrypted with Elliptic Curve Integrated Encryption Scheme
- **BioHash** — irreversible biometric hashing for secure template storage
- **Simple API** — configure, register, and authenticate users in a few lines of code

## Requirements

| Requirement | Minimum |
|---|---|
| iOS | 16.0+ |
| Xcode | 15.0+ |
| Swift | 5.9+ |
| Device | iPhone with TrueDepth camera |

## Installation

### Swift Package Manager

Add the package to your Xcode project:

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies...**
3. Enter the repository URL:
   ```
   https://github.com/biometricid/BiometricID.git
   ```
4. Select version **1.0.0** or later
5. Click **Add Package**

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/biometricid/BiometricID.git", from: "1.0.0")
]
```

## Quick Start

### 1. Configure the SDK

Call `config(with:)` once at app launch with your API key (get one at [biometricid.eu.com](https://biometricid.eu.com)):

```swift
import BiometricidSDK

do {
    try await BiometricIDSDK.shared.config(with: "YOUR_API_KEY")
} catch {
    print("Configuration failed: \(error.localizedDescription)")
}
```

### 2. Register a User

```swift
BiometricIDSDK.shared.registerUser(firstName: "John", lastName: "Doe") { result in
    switch result {
    case .success(let user):
        print("Registered: \(user.userId)")
    case .failure(let error):
        print("Registration failed: \(error.localizedDescription)")
    }
}
```

### 3. Authenticate a User

```swift
BiometricIDSDK.shared.login { result in
    switch result {
    case .success(let user):
        print("Welcome back, \(user.firstName)!")
    case .failure(let error):
        print("Login failed: \(error.localizedDescription)")
    }
}
```

## API Reference

### BiometricIDSDK

| Method | Description |
|---|---|
| `config(with: String) async throws` | Configure the SDK with your API key. Validates the key with the server and preloads the CoreML model. |
| `registerUser(firstName:lastName:completion:)` | Register a new user with biometric face data. Presents the camera UI automatically. |
| `login(completion:)` | Authenticate an existing user via face recognition. |

### BiometricidUser

Returned on successful registration or login:

| Property | Type | Description |
|---|---|---|
| `userId` | `String` | Unique user identifier |
| `firstName` | `String` | User's first name |
| `lastName` | `String` | User's last name |
| `lastLoginDate` | `Date` | Timestamp of the last login |

### BiometricIDError

| Case | Description |
|---|---|
| `apiKeyNotFound` | API key is invalid or not found |
| `accountNotActive` | Account is deactivated |
| `subscriptionInactive` | Subscription has expired |
| `userNotFound` | No matching user found during login |
| `userAlreadyExists` | User with this biometric data already registered |
| `reachedMaximumNumberOfUsers` | Account user limit reached |
| `userCancelled` | User dismissed the camera UI |
| `networkError(String)` | Network connectivity issue |
| `serverError(String)` | Server-side error |
| `biometricFailed(String)` | Face capture or processing failed |
| `authenticationFailed(String)` | Recognition score below threshold |

## Privacy

BiometricID SDK is designed with privacy at its core:

- **No image transmission** — all photos are processed on-device and immediately discarded
- **Embeddings only** — only 512-dimensional vectors (~2 KB) leave the device
- **ECIES encryption** — embeddings are encrypted before transmission
- **BioHash** — server stores irreversible hashes, not raw embeddings
- **No tracking** — the SDK collects no analytics or personal data

## Performance

| Metric | Value |
|---|---|
| Embedding generation | <50 ms (Neural Engine) |
| Recognition latency | <500 ms (end-to-end) |
| Memory footprint | <250 MB peak |
| Network payload | <25 KB (login), <100 KB (registration) |

## License

Proprietary. See [LICENSE](LICENSE) for details.

## Support

- Website: [biometricid.eu.com](https://biometricid.eu.com)
- Email: support@biometricid.eu.com
