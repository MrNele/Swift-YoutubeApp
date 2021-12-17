//
//  VideoModel.swift
//  YoutubeApp
//
//  Created by iMac on 15.12.21..
//

import Foundation
import Alamofire
class VideoModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    init() {
        getVideos()
    }
    
    func getVideos(){
        
        // Creates a URL object
        guard let url = URL(string: "\(Constants.API_URL)/playlistItems") else {
            return
        }
        
        // Gets a decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // Creates a URL request (for Alamofire it is imported)
        AF.request(
            url,
            parameters: ["part": "snippet", "platlistId": Constants.PLAYLIST_ID, "key": Constants.API_KEY]
        )
            // Alamofire provides this method basically checks if the response is a 200 response and if it isn't, then it will have this response as a result, be failure and otherwise it will be success, so as we are looking at the response, we can check those values and don't have to checking the actual code of the response.
            .validate()
        // Access to response itself. Since the response to decodable method, this response will have a value which is already decoded into a response object. This will just to decoding for me and give me a value.
        
            .responseDecodable(of: Response.self, decoder: decoder) {
                response in
        
                // Checks that call was successful (I only have to do is check the responses results)
                switch response.result {
                case.success:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                }
                
                // Updates the UI with the videos
                if let items = response.value?.items {
                    DispatchQueue.main.async {
                        self.videos = items
                    }
                }
            }
        
    }
    
}
