//
//  ContentView.swift
//  SwiftSecureDataEncryption
//
//  Created by Aruna Udayanga on 27/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var sensitiveText: String = "This is some sensitive data"
    @State private var encryptedData: Data?
    @State private var decryptedText: String = ""
    @State private var encryptionService = EncryptionService()
    @State private var encryptedDataList: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter sensitive data", text: $sensitiveText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Encrypt Data") {
                if let data = sensitiveText.data(using: .utf8) {
                    if let encrypted = encryptionService.encryptSensitiveData(data) {
                        encryptedData = encrypted
                        decryptedText = "Data encrypted successfully."
                        addToList(encrypted)
                    } else {
                        decryptedText = "Encryption failed."
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Decrypt Data") {
                if let encryptedData = encryptedData {
                    if let decryptedData = encryptionService.decryptSensitiveData(encryptedData) {
                        decryptedText = String(data: decryptedData, encoding: .utf8) ?? "Decryption failed."
                    } else {
                        decryptedText = "Decryption failed."
                    }
                } else {
                    decryptedText = "No encrypted data available."
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Rotate Encryption Key") {
                if let data = sensitiveText.data(using: .utf8) {
                    if let rotated = encryptionService.rotateEncryptionKey(for: data) {
                        encryptedData = rotated.encryptedData
                        decryptedText = "Key rotated and data re-encrypted successfully."
                        addToList(rotated.encryptedData)
                    } else {
                        decryptedText = "Key rotation failed."
                    }
                }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Text(decryptedText)
                .padding()
                .multilineTextAlignment(.center)
            
            List(encryptedDataList, id: \.self) { encryptedString in
                Text(encryptedString)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func addToList(_ data: Data) {
        let encodedString = data.base64EncodedString()
        encryptedDataList.append(encodedString)
    }
}

#Preview {
    ContentView()
}
