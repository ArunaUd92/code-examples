//
//  File.swift
//  LazyLoadingImagesSwiftUI
//
//  Created by Aruna Udayanga on 30/08/2024.
//

import Foundation

class ImageViewModel: ObservableObject {
    @Published var images: [ImageData] = []
    
    init() {
        loadImages()
    }
    
    private func loadImages() {
        // Simulating a large dataset with random image URLs
        for i in 1...1000 {
            let url = "https://via.placeholder.com/600/\(String(format: "%06X", Int.random(in: 0...0xFFFFFF)))"
            let description = "Image \(i)"
            let imageData = ImageData(url: url, description: description)
            images.append(imageData)
        }
    }
}
