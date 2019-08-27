//
//  ConfigurationManager.swift
//  Reddit Test
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

enum URLKey: String {
    case BASE = "BASE"
    case BASEAFTER = "BASE_AFTER"
}

class ConfigurationManager {
    static let instance = ConfigurationManager()
    
    private init() {}
    
    func urlForPath(urlKey: URLKey) -> String {
        if let plist = getPlist(), let urlString = plist[urlKey.rawValue] as? String {
            return urlString
        } else {
            print("Error reading plist")
            return ""
        }
    }
    
    func getPlist() -> [String: AnyObject]? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let plistPath: String? = Bundle.main.path(forResource: "url", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String: AnyObject]
            return plistData
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return nil
        }
    }
}
