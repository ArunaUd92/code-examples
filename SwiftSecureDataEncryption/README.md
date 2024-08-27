# SwiftUI Data Encryption Example

This project demonstrates how to securely handle sensitive data in a SwiftUI application using AES-256 encryption. It includes functionalities for encrypting, decrypting, and rotating encryption keys, with the encrypted data being displayed in a list within the app.

## Features

* **ES-256 Encryption:** Securely encrypts sensitive data using AES-256.
* **Keychain Integration:** Stores encryption keys and initialization vectors (IVs) securely in the iOS Keychain.
* **Key Rotation:** Supports generating a new encryption key and re-encrypting existing data.
* **SwiftUI Interface:** Provides a simple and interactive UI for managing encrypted data.

## Project Structure

* **AES256Encryption:** Handles the encryption and decryption of data using AES-256.
* **KeychainManager:** Manages secure storage and retrieval of encryption keys and IVs.
* **KeyRotationManager:** Supports key generation, rotation, and re-encryption of data.
* **EncryptionService:** Provides an interface for encryption, decryption, and key rotation, integrating the above components.

## Getting Started
### Prerequisites

* Xcode 12 or later
* Swift 5.3 or later
* iOS 14.0 or later
