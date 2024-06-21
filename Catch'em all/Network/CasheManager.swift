//
//  CasheManager.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 18.06.2024.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    
    private let cache = NSCache<NSString, NSData>()
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func cachePokemonsDetailInfoData(_ model: Pokemon, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            cache.setObject(NSData(data: encoded), forKey: key as NSString)
        }
    }
    
    func getPokemonsDetailInfoData(forKey key: String) -> Pokemon? {
        if let cachedData = cache.object(forKey: key as NSString) as Data? {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Pokemon.self, from: cachedData) {
                return model
            }
        }
        return nil
    }
    
    func cacheImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
        
    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
