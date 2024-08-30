//
//  RemoteImageView.swift
//  LazyLoadingImagesSwiftUI
//
//  Created by Aruna Udayanga on 30/08/2024.
//

import SwiftUI
import Foundation

struct RemoteImageView: View {
    @ObservedObject var loader: ImageLoader
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder
    }
    
    var body: some View {
        image
           // .resizable()
           // .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100) // Ensure a fixed size to demonstrate `fill`
            .clipped() // Clips the content to the frame size
    }
    
    private var image: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                placeholder
                    .resizable()
            }
        }
    }
}
