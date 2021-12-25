//
//  GIDSignInManager.swift
//  YoutubeApp
//
//  Created by iMac on 25.12.21..
//

import Foundation
import GoogleSignIn

class GoogleSignInManager: NSObject, GIDSignIn, ObservableObject {
    
    @Published var signedIn = false
    var accessToken = ""
    
    func sign(_ signIn: GIDSignIn!, didSignFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            }
            else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        accessToken = user.authentication.accessToken
        
        signedIn = true
        
    }
    
}
