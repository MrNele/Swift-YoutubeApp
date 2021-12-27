//
//  YoutubeRequest.swift
//  YoutubeApp
//
//  Created by iMac on 25.12.21..
//

import Foundation
import Alamofire

extension Session {
    
    // Sends an authenticated request to the YouTube data API v3
    func requestYoutube (
        relativeUrl: String,
        method: HTTPMethod,
        json: Bool = false,
        parameters: Parameters? = nil,
        accessToken: String,
        completion: ((AFDataResponse<Any>) -> Void)? = nil
    ) {
        
        // Creates a URL from the given path
        guard let url = URL(string: "\(Constants.API_URL)/\(relativeUrl)") else {
            print("Couldn't get URL for relative path \(relativeUrl)")
            return
        }
        
        // Creates the AF request
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: json ? JSONEncoding.default: URLEncoding.default,
            headers: ["Authorization": "Bearer \(accessToken)", "Accept": "application/json"]
        )
            .validate()
            .responseJSON { response in
                
                // Checks the status of the request
                switch response.result {
                case .success:
                    break
                case .failure(let error):
                    print("Youtube data api call failed with error \(error.failureReason ?? error.localizedDescription)")
                return
                }
                
                // Calls the completition handler
                if let completion = completion {
                    completion(response)
                }
            }
    }
}
