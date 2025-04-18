//
//  ImageCache.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/17/25.
//

import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheURL: URL

    private init() {
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        diskCacheURL = cacheDirectory.appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }
    
    func image(forKey key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        }
        
        let fileURL = diskCacheURL.appendingPathComponent(key)
        if let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    func store(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        
        let fileURL = diskCacheURL.appendingPathComponent(key)
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: fileURL)
        }
    }
}

extension ImageCache {
    func clearMemoryCache(forKey key: String) {
        memoryCache.removeObject(forKey: key as NSString)
    }
    
    func clearDiskCache(forKey key: String) {
        let fileURL = diskCacheURL.appendingPathComponent(key)
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    func fileURL(forKey key: String) -> URL {
        return diskCacheURL.appendingPathComponent(key)
    }
}
