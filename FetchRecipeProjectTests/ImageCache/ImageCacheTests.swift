//
//  ImageCacheTests.swift
//  FetchRecipeProjectTests
//
//  Created by Chi-Hsien Wu on 4/18/25.
//

import Testing
import XCTest
import UIKit
@testable import FetchRecipeProject

struct ImageCacheTests {

    @Test("Store and retrieve image from memory cache")
    func testStoreAndRetrieveFromMemoryCache() {
        guard let image = UIImage(systemName: "house") else {
            XCTFail("Failed to create test image")
            return
        }
        let cache = ImageCache.shared
        let testKey = "memoryCacheTestKey"
        
        cache.clearMemoryCache(forKey: testKey)
        cache.clearDiskCache(forKey: testKey)
        
        #expect(cache.image(forKey: testKey) == nil, "Expected image to be nil before storing in memory cache")
        
        cache.store(image, forKey: testKey)
        cache.clearDiskCache(forKey: testKey)
        
        #expect(cache.image(forKey: testKey) != nil, "Expected image to be retrieved from memory cache")
    }
    
    @Test("Store image to disk cache")
    func testStoreImageToDiskCache() {
        guard let image = UIImage(systemName: "house") else {
            XCTFail("Failed to create test image")
            return
        }
        
        let cache = ImageCache.shared
        let testKey = "diskCacheTestKey"
        let fileURL = cache.fileURL(forKey: testKey)
        
        cache.clearDiskCache(forKey: testKey)
        
        #expect(!FileManager.default.fileExists(atPath: fileURL.path), "File should not exist before storing")

        cache.store(image, forKey: testKey)
        
        #expect(FileManager.default.fileExists(atPath: fileURL.path), "Expected image file to exist at path after storing")
    }
    
    @Test("Retrieve image from disk cache")
    func testRetrieveImageFromDiskCache() {
        guard let image = UIImage(systemName: "house") else {
            XCTFail("Failed to create test image")
            return
        }
        
        let cache = ImageCache.shared
        let testKey = "diskCacheTestKey"
        
        cache.store(image, forKey: testKey)
        cache.clearMemoryCache(forKey: testKey)
        
        #expect(cache.image(forKey: testKey) != nil, "Expected image to be retrieved from disk cache")
    }
}
