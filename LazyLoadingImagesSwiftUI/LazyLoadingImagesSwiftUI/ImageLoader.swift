//
//  ImageLoader.swift
//  LazyLoadingImagesSwiftUI
//
//  Created by Aruna Udayanga on 30/08/2024.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: String
    private var cancellable: AnyCancellable?
    private static let cache = NSCache<NSString, UIImage>()
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        if let cachedImage = Self.cache.object(forKey: url as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let imageUrl = URL(string: url) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                if let image = image {
                    Self.cache.setObject(image, forKey: self?.url as NSString? ?? "")
                }
                self?.image = image
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
