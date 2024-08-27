//
//  EncryptionService.swift
//  SwiftSecureData
//
//  Created by Aruna Udayanga on 27/08/2024.
//

import Foundation

class EncryptionService {
    private let keyRotationManager = KeyRotationManager()

    func encryptSensitiveData(_ data: Data) -> Data? {
        guard let (key, iv) = keyRotationManager.getKeyAndIV() else {
            return nil
        }
        return AES256Encryption.encrypt(data: data, key: key, iv: iv)
    }

    func decryptSensitiveData(_ encryptedData: Data) -> Data? {
        guard let (key, iv) = keyRotationManager.getKeyAndIV() else {
            return nil
        }
        return AES256Encryption.decrypt(data: encryptedData, key: key, iv: iv)
    }

    func rotateEncryptionKey(for data: Data) -> (newKey: Data, newIV: Data, encryptedData: Data)? {
        return keyRotationManager.rotateKey(data: data)
    }
}
