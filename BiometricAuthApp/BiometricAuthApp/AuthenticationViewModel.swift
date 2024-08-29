//
//  AuthenticationViewModel.swift
//  BiometricAuthApp
//
//  Created by Aruna Udayanga on 29/08/2024.
//

import SwiftUI
import LocalAuthentication
import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your secure data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.errorMessage = authenticationError?.localizedDescription
                    }
                }
            }
        } else {
            self.errorMessage = "Biometric authentication is not available."
        }
    }
}
