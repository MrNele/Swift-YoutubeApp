//
//  Home.swift
//  YoutubeApp
//
//  Created by iMac on 16.12.21..
//

import SwiftUI

let backgroundColor = Color(red: 31 / 255, green: 33 / 255, blue: 36 / 255)

struct Home: View {
    @StateObject var model = VideoModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.videos,
                        id:\.videoId) { video in
                    // Displays a row for each video
                    VideoRow(videoPreview:
                                VideoPreview(video:
                                video))
                        .padding()
                }
            }
            .padding(.top, 20)
        }
            // Sets the text color to be white against the dark background
            .foregroundColor(.white)
            // Sets the background color to the custom color
            .background(backgroundColor
                            .edgesIgnoringSafeArea(.all))
            // Animates transitions in this view
            animation(.easeOut)
        }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
