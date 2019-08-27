//
//  API.swift
//  Reddit Test
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidURL
    case invalidJSONData
    case requestUnavailable
}

enum GetResult {
    case success(Any)
    case failure(Error)
}

class API {
    let configurationManager = ConfigurationManager.instance
    
    func getPosts(urlKey: URLKey, completed: @escaping (GetResult) -> ()) {
        let url = getURL(urlKey: urlKey)
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            guard response.result.error == nil else {
                return completed(.failure(response.result.error!))
            }
            
            guard let object = response.result.value as? [String: Any] else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            guard let data = object["data"] as? [String: Any] else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            guard let children = data["children"] as? [[String: Any]], let afterUser = data["after"] as? String else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            var postArray = [Post]()
            
            for i in children {
                let post = Post(dict: i)
                postArray.append(post)
            }
            
            return completed(.success([afterUser: postArray]))
        }
    }
    
    func getPostsAfter(urlKey: URLKey, afterUser: String, completed: @escaping (GetResult) -> ()) {
        let url = getURL(urlKey: urlKey, afterUser)
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            guard response.result.error == nil else {
                return completed(.failure(response.result.error!))
            }
            
            guard let object = response.result.value as? [String: Any] else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            guard let data = object["data"] as? [String: Any] else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            guard let children = data["children"] as? [[String: Any]], let afterUser = data["after"] as? String else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            var postArray = [Post]()
            
            for i in children {
                let post = Post(dict: i)
                postArray.append(post)
            }
            
            return completed(.success([afterUser: postArray]))
        }
    }

    func getURL(urlKey: URLKey, _ afterUser: String? = nil) -> URL {
        let urlString = configurationManager.urlForPath(urlKey: urlKey)
        
        if let after = afterUser {
            let compendingUrl = urlString.replacingOccurrences(of: "{username}", with: after)
            return URL(string: compendingUrl)!
        }

        return URL(string: urlString)!
    }
}
