//
//  YouTubeVideoPlayer.swift
//  YoutubeApp
//
//  Created by iMac on 16.12.21..
//

import SwiftUI
import WebKit

struct YouTubeVideoPlayer: UIViewRepresentable {
    var video: Video
    
    func makeUIView(context: Context) -> some UIView {
        // Creates the web view
        let view = WKWebView()
        
        // Sets the background color for the view
        view.backgroundColor = UIColor(backgroundColor)
        
        // Creates the url for the video
        let embedUrlString = Constants.YT_EMBED_URL + video.videoId
        
        // Loads the video into the web view
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        view.load(request)
        
        // Returns the web view
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct YouTubeVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeVideoPlayer(video: Video())
    }
}
