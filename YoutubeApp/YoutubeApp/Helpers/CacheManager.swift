//
//  CacheManager.swift
//  YoutubeApp
//
//  Created by iMac on 15.12.21..
//

import Foundation

class CacheManager {
    
    static var cache = [String: Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
       cache[url] = data
    }
    static func getVideoCache (_ url: String) -> Data? {
    // Tries and gets the data for the specified URL
    return cache[url]
        
    }
    
}
