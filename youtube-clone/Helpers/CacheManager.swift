//
//  CacheManager.swift
//  youtube-clone
//
//  Created by Ajaya Mati on 20/06/22.
//

import Foundation

class CacheManager{
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url:String,_ data:Data){
        cache[url] = data
    }
    
    static func getVideoCache(_ url:String) -> Data?{
        //try to get the data for the specified url
        
        return cache[url]
    }
}
