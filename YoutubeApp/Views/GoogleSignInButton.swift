//
//  GoogleSignInButton.swift
//  YoutubeApp
//
//  Created by iMac on 25.12.21..
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresantable {
  
    func makeUIView(context: Context) ->
    some UIView {
        // Creates the view
        let view = GIDSignInButton
        
        // Sets it's presenting view controller
        // Since the button is displayed in the home view, we know it's presenting view controller will be the root view controller for our app
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        
        // Returns the configured button
        return view
    }
    
}

struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton()
    }
}
