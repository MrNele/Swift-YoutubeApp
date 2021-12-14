//
//  Video.swift
//  YoutubeApp
//
//  Created by iMac on 14.12.21..
//

import Foundation

struct Video: Decodable {
        
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        // from the API
        case snippet
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        // by default will be url
        case thumbnail = "url"
        case videoId
        
    }
    
    // implement init from decoder method
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parsing the title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parsing the description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parsing the published date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parsing thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parsing the video ID
        let resourceContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceContainer.decode(String.self, forKey: .videoId)
    }
    
}
