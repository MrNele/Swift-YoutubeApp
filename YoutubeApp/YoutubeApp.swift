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
        GIDSignIn.sharedInstance().clientID = Constants.GID_SIGN_IN_ID
        GIDSignIn.sharedInstance().delegate = signInManager
        
        // Specifies that we need to authenticate users for YouTube access
        GIDSignIn.sharedInstance().scopes.append(Constants.YT_AUTH_SCOPE)
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(signInManager)
        }
    }
}
