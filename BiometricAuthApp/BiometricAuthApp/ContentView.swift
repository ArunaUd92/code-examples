//
//  ContentView.swift
//  BiometricAuthApp
//
//  Created by Aruna Udayanga on 29/08/2024.
//

import SwiftUI

struct ContentView: View {
    // Using @StateObject to create an instance of AuthenticationViewModel that will be used throughout the lifecycle of this view
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            // Check if the user is authenticated
            if viewModel.isAuthenticated {
                // If authenticated, show the secure content
                SecureContentView()
            } else {
                // If not authenticated, show authentication prompt
                VStack {
                    // Informational text to prompt the user for authentication
                    Text("Please authenticate to proceed")
                        .font(.title) // Set font size and style
                        .padding() // Add padding around the text
                    
                    // If there is an error message, display it
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red) // Set text color to red for errors
                            .padding() // Add padding around the error message
                    }
                    
                    // Button to trigger authentication process
                    Button(action: {
                        // Call the authenticate function from the view model
                        viewModel.authenticate()
                    }) {
                        // Text within the button
                        Text("Authenticate")
                            .padding() // Add padding inside the button
                            .background(Color.blue) // Set background color of the button
                            .foregroundColor(.white) // Set text color to white
                            .cornerRadius(8) // Make the button corners rounded
                    }
                }
            }
        }
        .padding() // Add padding around the entire VStack
    }
}

// Struct for the secure content view that is displayed after successful authentication
struct SecureContentView: View {
    var body: some View {
        Text("This is a secure content area.")
            .font(.largeTitle) // Set font size and style
            .padding() // Add padding around the text
    }
}

#Preview {
    ContentView()
}
