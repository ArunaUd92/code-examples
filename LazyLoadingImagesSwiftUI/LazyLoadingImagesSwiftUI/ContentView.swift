//
//  ContentView.swift
//  LazyLoadingImagesSwiftUI
//
//  Created by Aruna Udayanga on 30/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.images) { imageData in
                HStack {
                    RemoteImageView(url: imageData.url)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(imageData.description)
                        .font(.headline)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Lazy Loading Images")
        }
    }
}

#Preview {
    ContentView()
}
