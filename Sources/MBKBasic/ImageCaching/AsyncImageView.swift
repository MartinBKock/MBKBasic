//
//  SwiftUIView.swift
//  
//
//  Created by Martin Kock on 05/07/2024.
//

import SwiftUI

public struct AsyncImageView: View {
    @State private var loadedImage: UIImage?
    private var imageLoader = ImageCacheService.shared
    let urlString: String
    let placeholder: Image
    
    init(urlString: String, placeholder: Image = Image(systemName: "photo")) {
        self.urlString = urlString
        self.placeholder = placeholder
    }
    
    public var body: some View {
        if let image = loadedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .onDisappear {
                    loadedImage = nil
                }
        } else {
            placeholder
                .resizable()
                .scaledToFit()
                .onAppear {
                    loadedImage = nil
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: setHTTPSinsteadOfHTTP(urlString: urlString)) else { return }
        imageLoader.loadImage(withURL: url) { image in
            if let image = image {
                DispatchQueue.main.async {
                    loadedImage = image
                }
            }
        }
    }
    
    private func setHTTPSinsteadOfHTTP(urlString: String) -> String {
        return urlString.replacingOccurrences(of: "http://", with: "https://")
    }
}
