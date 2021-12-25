//
//  Response.swift
//  YoutubeApp
//
//  Created by iMac on 14.12.21..
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]
    
    enum CodingKeys: String, CodingKey {
        
        case items
        
    }
    
    init(from decoder: Decoder) throws {
        // Decoding container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Assign this items property to whatever you can decode as array [Video].self from items key. Since is video decodable by itself it will use its init from decoder method to create these videos and then fill array with some inits assigned to these property in here
        self.items = try container.decode([Video].self, forKey: .items)
        
    }
    
}
