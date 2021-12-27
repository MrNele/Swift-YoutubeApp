//
//  LikeAndSubscribe.swift
//  YoutubeApp
//
//  Created by iMac on 25.12.21..
//

import SwiftUI

struct LikeAndSubscribe: View {
    @ObservedObject var ratingModel: RatingModel
    
    init(video: Video, accessToken: String) {
        // Creates the rating model from the video and token
        self.ratingModel = RatingModel(video: video, accessToken: accessToken)
    }
    
    var likeText: String {
        // If the video is liked, the text shouls say "Unlike"
        // Otherwise, the option is to like the video
        return ratingModel.isLiked ? "Unlike" : "Like \u{1f44d}"
    }
    
    var subscribeText: String {
        // If the user is subscribed, the option is to unsubscribe
        // Otherwise, the optiion is to subscribe
        return ratingModel.isSubscibed ? "Unsubscribe" : "Subscribe"
    }
    
    var body: some View {
        // Displays buttons to like and subsvribe
        // Evenly spaced out
        HStack {
            
            Button(likeText) {
                // Toogles the user's rating for the video
                ratingModel.toggleLike()
            }
            
            Spacer()
            
            Button(subscribeText) {
                // Toogles the user's subscription status
                ratingModel.toggleSubscribe()
            }
        }
    }
}

struct LikeAndSubscribe_Previews: PreviewProvider {
    static var previews: some View {
        LikeAndSubscribe(video: Video(), accessToken: "")
    }
}
