//
//  VideoRow.swift
//  YoutubeApp
//
//  Created by iMac on 16.12.21..
//

import SwiftUI

struct VideoRow: View {
    @ObservedObject var videoPreview: VideoPreview
    @State private var isPresenting = false
    @State private var imageHeight: CGFloat = 0
    
    var body: some View {
        Button(action: {
            // Presents the detail sheet
            isPresenting = true
        }) {
            VStack(alignment: .leading, spacing: 10) {
                
                // Displays the thumbnail image
                GeometryReader {
                    geometry in
                    
                    // Creates an image from the video preview's data
                    Image(uiImage: UIImage(data:
                                            videoPreview
                                            .thumbnailData) ??
                          UIImage())
                        .resizable() // proportions are off, so, scalledToFill
                        .scaledToFill()
                    // Sets the aspect ratio of the frame to be 16:9 because it is to large for a screen
                        .frame(width: geometry.size.width, height: geometry.size.width *  9 / 16)
                        .clipped() // removes any exterior image that's outside of the frame
                        .onAppear{
                            // Updates the height of the image
                            imageHeight = geometry.size.width * 9 / 16
                        }
                }
                
                // Sets the height explicity so the geometry reader is proposed height is not collapsed
                .frame(height: imageHeight)
                
                // Displays the video's title
                Text(videoPreview.title)
                    .bold()
                
                // Displays the video's date
                Text(videoPreview.date)
                    .foregroundColor(.gray)
            }
            .font(.system(size: 19))
        }
        .sheet(isPresented: $isPresenting,
               content: {
            // Displays the detail view for the video
            VideoDetail(video: videoPreview.video)
        })
    }
}

struct VideoRow_Previews: PreviewProvider {
    static var previews: some View {
        VideoRow(videoPreview: VideoPreview(video: Video()))
    }
}
