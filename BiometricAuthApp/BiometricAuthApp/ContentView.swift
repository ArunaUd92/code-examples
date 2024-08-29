//
//  ContentView.swift
//  BiometricAuthApp
//
//  Created by Aruna Udayanga on 29/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isAuthenticated {
                SecureContentView()
            } else {
                VStack {
                    Text("Please authenticate to proceed")
                        .font(.title)
                        .padding()
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button(action: {
                        viewModel.authenticate()
                    }) {
                        Text("Authenticate")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
}

struct SecureContentView: View {
    var body: some View {
        Text("This is a secure content area.")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    ContentView()
}
