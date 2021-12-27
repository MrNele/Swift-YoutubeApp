//
//  RatingModel.swift
//  YoutubeApp
//
//  Created by iMac on 25.12.21..
//

import Foundation
import Alamofire

class RatingModel: ObservableObject {
    
    var video: Video
    var accessToken: String
    var subscriptionId: String?
    
    @Published var isLiked = false
    @Published var isSubscibed = false
    
    init(video: Video, accessToken: String) {
        self.video = video
        self.accessToken = accessToken
        
        // Sets the initial status for the UI
        getRating()
        getSubscriptionStatus()
    }
    
}

// Support for reading and updating the like status for a video
extension RatingModel {
    
    // Gets the current users rating for the video
    func getRating() {
        AF.requestYoutube(
            relativeUrl: "videos/getRating",
            method: .get,
            parameters: ["id": video.videoId, "key": Constants.API_KEY],
            accessToken: accessToken
        ) { response in
            
            // Gets the rating from the response JSON
            if let json = response.value as? [String: Any],
               let items = json["items"] as? [[String: String]],
               let rating = items.first?["rating"]
            {
                // Update the UI with the rating's value
                DispatchQueue.main.async {
                    self.isLiked = rating == "like"
                }
            } else {
                print("Could not get rating")
            }
            
            
        }
    }
    
    // Changes the current users rating for the video
    func toggleLike() {
        
        // If the video is currently liked, send a rating of none to remove the like
        
        // Otherwise, send a rating of like
        
        let rating = isLiked ? "none" : "like"
        
        AF.requestYoutube(
            relativeUrl: "videos/rate",
            method: .post,
            parameters: ["id": video.videoId, "rating": rating, "key": Constants.API_KEY],
            accessToken: accessToken
        ) { response in
            
            // Upon success, flip the value in the UI
            DispatchQueue.main.async {
                self.isLiked.toggle()
            }
        }
    }
    
}

// Support for reading and updating the subscription status of the channel
extension RatingModel {
    
    // Gets the current user's the subscription status for the channel
    func getSubscriptionStatus() {
        
        AF.requestYoutube(relativeUrl: "subscriptions",
                          method: .get,
                          parameters: ["part": "id", "forChannelId": Constants.CHANNEL_ID, "mine": true, "key": Constants.API_KEY],
                          accessToken: accessToken
        )
        { response in
            
            // Gets the response items from the JSON
            if let json = response.value as? [String: Any],
               let items = json["itens"] as? [Any]
            {
                // Tries to get the subscription ID
                if let item = items.first as? [String: String],
                   let id = item["id"] {
                    self.subscriptionId = id
                }
                
                // Updates the UI
                DispatchQueue.main.async {
                    // The user is subscribed if there are items
                    self.isSubscibed = !items.isEmpty
                }
            }
        }
        
    }
    
    // Changes the users subscription status for the channel
    func toggleSubscribe() {
        
        if isSubscibed {
            unsubscribe()
        } else {
            subscribe()
        }
    }
    
    // Subscribes to the channel
    func subscribe() {
        
        // HTTP body to send along with the request
        let body: [String: Any] = [
            "snippet": [
                "resourceId": [
                    "channelId": Constants.CHANNEL_ID,
                    "kind": "youtube#channel"
                ]
            ]
        ]
        
        AF.requestYoutube(
                          relativeUrl: "subscriptions?part=snippet&key=\(Constants.API_KEY)",
                          method: .post,
                          json: true,
                          parameters: body,
                          accessToken: accessToken
        ) { response in
            
            // Gets the subscription ID from the response
            if let json = response.value as? [String: Any],
               let id = json["id"] as? String {
                
                // Updates the current subscription id
                self.subscriptionId = id
                
                // Updates the UI
                DispatchQueue.main.async {
                    self.isSubscibed = true
                }
                } else {
                    print("Couldn't subscribe")
                }
            }
                
        }
    


// Unsubscribes from the channel
func unsubscribe() {

    // I must have a subscription ID to unsubscribe
    guard let subscriptionId = subscriptionId else {
        print("Error: Tried to unsubscribe with no subscription ID.")
        return
    }

    AF.requestYoutube(
                      relativeUrl: "subscriptions",
                      method: .delete,
                      parameters: ["id": subscriptionId, "key": Constants.API_KEY],
                      accessToken: accessToken
    ) { response in
        
        // Clears the current subscriptionId
        self.subscriptionId = nil
        
        // Updates the UI
        DispatchQueue.main.sync {
            self.isSubscibed = false
        }
        
    }
    
}


}
