//
//  Home.swift
//  YoutubeApp
//
//  Created by iMac on 16.12.21..
//

import SwiftUI
import GoogleSignIn

let backgroundColor = Color(red: 31 / 255, green: 33 / 255, blue: 36 / 255)

struct Home: View {
    @EnvironmentObject var signInManager: GoogleSignInManager
    @StateObject var model = VideoModel()
    @State private var rowSize: CGSize = .zero
    
    var body: some View {
        VStack {
            
            // Displays the sign in button if the user is not signed in
            if !signInManager.signedIn {
                GoogleSignInButton()
                    .padding()
                    .frame(height: 60)
                // moves in and out from the top
                    .transition(.move(edge: .top))
                    .onOpenURL(perform: { url in
                        // Opens sign in URL when the button is clicked
                        GIDSignIn.sharedInstance.handle(url)
                    })
            }
            
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
            // If the user is signed in, show the sign out button
            if signInManager.signedIn{
                Button("Sign Out") {
                    // Sighs out
                    GIDSignIn.sharedInstance()?.signOut()
                    // Updates the sign in manager
                    signInManager.signedIn = false
                }
                .padding()
                // Moves in and out from the bottom
                .transition(.move(edge: .bottom))
            }
            
        }
        // Sets the text color to be white against the dark background
        .foregroundColor(.white)
        // Sets the background color to the custom color
        .background(backgroundColor
                        .edgesIgnoringSafeArea(.all))
        // Animates transitions in this view
        animation(_:.easeOut)
            .onAppear{
                // Restores the users previous sign in status
                GIDSignIn.sharedInstance.restorePreviousSignIn()
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(GoogleSignInManager())
    }
}
