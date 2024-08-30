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
    @Published var isAuthenticated = false // Tracks authentication state
    @Published var errorMessage: String? // Stores error messages, if any
    
    func authenticate() {
        let context = LAContext() // Create a context for biometric authentication
        var error: NSError?
        
        // Check if the device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your secure data." // Reason for authentication
            
            // Perform biometric authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true // Update state on successful authentication
                    } else {
                        self.errorMessage = authenticationError?.localizedDescription // Update error message if authentication fails
                    }
                }
            }
        } else {
            self.errorMessage = "Biometric authentication is not available." // Handle case where biometrics are not available
        }
    }
}
