//
//  Post.swift
//  Reddit Test
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

class Post {
    private var _subreddit: String?
    private var _title: String?
    private var _username: String?
    private var _summary: String?
    private var _datePosted: Int?
//    var imageURL: String?
//    var videoURL: String?
    
    var upvote: Int = 0
    var comments: Int = 0
    
    private enum APIKeys: String {
        case Data = "data"
        case Subreddit = "subreddit"
        case Title = "title"
        case Username = "author_fullname"
        case Summary = "selftext"
        case Date = "created"
        case Upvote = "ups"
        case Comments = "num_comments"
    }

    init(dict: [String: Any]) {
        if let object = dict["data"] as? [String: Any] {
            _subreddit = object[APIKeys.Subreddit.rawValue] as? String
            _title = object[APIKeys.Title.rawValue] as? String
            _username = object[APIKeys.Username.rawValue] as? String
            _summary = object[APIKeys.Summary.rawValue] as? String
            _datePosted = object[APIKeys.Date.rawValue] as? Int
            upvote = object[APIKeys.Upvote.rawValue] as! Int
            comments = object[APIKeys.Comments.rawValue] as! Int
        }
    }
    
    
    var subreddit: String {
        if let subreddit = self._subreddit {
            return subreddit
        }
        return ""
    }
    
    var subRedditCellTitle: String {
        return "r/\(subreddit)"
    }
    
    var title: String {
        if let title = self._title {
            return title
        }
        return ""
    }
    
    var username: String {
        if let username = self._username {
            return username
        }
        return ""
    }
    
    var userCellTitle: String {
        return "u/\(username)"
    }
    
    
    var summary: String {
        if let summary = self._summary {
            return summary
        }
        return ""
    }
}
