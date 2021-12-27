//
//  VideoDetail.swift
//  YoutubeApp
//
//  Created by iMac on 16.12.21..
//

import SwiftUI

struct VideoDetail: View {
    @EnvironmentObject var signInManager: GoogleSignInManager
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
            
            // If the user is signed in, shows the option to like and subscribe
            if signInManager.signedIn {
                LikeAndSubscribe(video: video, accessToken: signInManager.accessToken)
            // Sets the buttons to fade on insert
                    .transition(.opacity)
                // Uses the parent views animation
                    .animation(.default)
            }
            
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
            .environmentObject(GoogleSignInManager())
    }
}
