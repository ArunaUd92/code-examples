//
//  AES256.swift
//  SwiftSecureData
//
//  Created by Aruna Udayanga on 27/08/2024.
//

import CommonCrypto
import Foundation

class AES256Encryption {
    private static let keySize = kCCKeySizeAES256
    private static let blockSize = kCCBlockSizeAES128

    static func encrypt(data: Data, key: Data, iv: Data?) -> Data? {
        return crypt(data: data, key: key, iv: iv, operation: CCOperation(kCCEncrypt))
    }

    static func decrypt(data: Data, key: Data, iv: Data?) -> Data? {
        return crypt(data: data, key: key, iv: iv, operation: CCOperation(kCCDecrypt))
    }

    private static func crypt(data: Data, key: Data, iv: Data?, operation: CCOperation) -> Data? {
        var outLength = Int(0)
        let outData = NSMutableData(length: data.count + blockSize)!
        
        let keyBytes = key.withUnsafeBytes { $0.baseAddress }
        let dataBytes = data.withUnsafeBytes { $0.baseAddress }
        let outBytes = outData.mutableBytes.assumingMemoryBound(to: UInt8.self)
        
        let cryptStatus = CCCrypt(operation,
                                  CCAlgorithm(kCCAlgorithmAES),
                                  CCOptions(kCCOptionPKCS7Padding),
                                  keyBytes, keySize,
                                  iv?.withUnsafeBytes { $0.baseAddress },  // IV is optional
                                  dataBytes, data.count,
                                  outBytes, outData.length,
                                  &outLength)
        
        if cryptStatus == CCCryptorStatus(kCCSuccess) {
            outData.length = outLength
            return outData as Data
        } else {
            return nil
        }
    }
}
