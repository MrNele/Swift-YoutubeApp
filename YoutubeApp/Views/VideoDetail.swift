//
//  VideoDetail.swift
//  YoutubeApp
//
//  Created by iMac on 16.12.21..
//

import SwiftUI

struct VideoDetail: View {
    var video: Video
    
    var date: String {
        // Creates a formatted date from the video's date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from: video.published)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Displays the video's title
            Text(video.title)
                .bold()
            // Displays the date
            Text(date)
                .foregroundColor(.gray)
            
            // Displays the video
            YouTubeVideoPlayer(video: video)
                .aspectRatio(CGSize(width: 1280, height: 720),
                contentMode: .fit)
            
            // Displays the video descriptions
            ScrollView{
                Text(video.description)
            }
        }
        .font(.system(size: 19))
        .padding()
        .padding(.top, 40)
        .background(backgroundColor
                        .edgesIgnoringSafeArea(.all))
    }
}

struct VideoDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetail(video: Video())
    }
}
