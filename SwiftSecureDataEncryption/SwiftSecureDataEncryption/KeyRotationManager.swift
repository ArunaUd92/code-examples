//
//  KeyRotationManager.swift
//  SwiftSecureData
//
//  Created by Aruna Udayanga on 27/08/2024.
//

import Foundation
import CommonCrypto

class KeyRotationManager {
    private let keychainKey = "com.example.app.encryptionKey"
    private let ivKey = "com.example.app.iv"

    func rotateKey(data: Data) -> (newKey: Data, newIV: Data, encryptedData: Data)? {
        guard let newKey = generateKey(), let newIV = generateIV() else { return nil }
        
        guard let encryptedData = AES256Encryption.encrypt(data: data, key: newKey, iv: newIV) else { return nil }
        
        let keySaved = KeychainManager.save(key: keychainKey, data: newKey)
        let ivSaved = KeychainManager.save(key: ivKey, data: newIV)
        
        if keySaved && ivSaved {
            return (newKey, newIV, encryptedData)
        } else {
            return nil
        }
    }
    
    private func generateKey() -> Data? {
        var keyData = Data(count: kCCKeySizeAES256)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, kCCKeySizeAES256, $0.baseAddress!)
        }
        return result == errSecSuccess ? keyData : nil
    }

    private func generateIV() -> Data? {
        var ivData = Data(count: kCCBlockSizeAES128)
        let result = ivData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, $0.baseAddress!)
        }
        return result == errSecSuccess ? ivData : nil
    }

    func getKeyAndIV() -> (key: Data, iv: Data)? {
        if let key = KeychainManager.load(key: keychainKey), let iv = KeychainManager.load(key: ivKey) {
            return (key, iv)
        }
        return nil
    }
}
