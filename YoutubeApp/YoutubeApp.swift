//
//  YoutubeApp.swift
//  YoutubeApp
//
//  Created by iMac on 11.12.21..
//

import SwiftUI
import GoogleSignIn

@main
struct YoutubeApp: App {
    
    // Creates a google sign in manager
    let signInManager = GoogleSignInManager()
    
    init () {
        
        // Sets the client ID and delegate
        GIDSignIn.sharedInstance()?.clientID = Constants.GID_SIGN_IN_ID
        GIDSignIn.sharedInstance()?.delegate = signInManager
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(signInManager)
        }
    }
}
