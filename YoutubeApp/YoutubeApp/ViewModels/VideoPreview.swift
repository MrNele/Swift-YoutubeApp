//
//  VideoPreview.swift
//  YoutubeApp
//
//  Created by iMac on 15.12.21..
//

import Foundation
import Alamofire

class VideoPreview: ObservableObject {
    
    @Published var thumbnailData = Data()
    @Published var title: String
    @Published var date: String
    
    var video: Video
    
    init (video: Video) {
        
        // Sets the video and title
        self.video = video
        self.title = video.title
        
        
        // Sets the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.date = df.string(from: video.published)
                
        // Download the image data
        guard video.thumbnail != "" else {return}
        
        // Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(video.thumbnail) {
            // Sets the thumbnail
            thumbnailData = cachedData
            return
        }
        
        // Gets a url from the thumbnail
        guard let url = URL(string: video.thumbnail) else { return }
        
        // Create the request
        AF.request(url).validate().responseData {
            response in
            
            if let data = response.data {
                // Saves the data in the cash
                CacheManager.setVideoCache(video.thumbnail, data)
                
                // Sets the image
                DispatchQueue.main.async {
                    self.thumbnailData = data
                }
            }
        }
    }
    
}
