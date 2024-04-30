//
//  File.swift
//  
//
//  Created by Martin Kock on 30/03/2024.
//

import Foundation
import UIKit

public class ImageCaching {
    
    // MARK: - Private init
    private init() {}
    
    // MARK: - Private Properties
    
    // MARK: - Public properties
    public var imageCache: NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    
    // MARK: - Private functions
    
    // MARK: - Public functions
    public static let shared = ImageCaching()
    
    
}
