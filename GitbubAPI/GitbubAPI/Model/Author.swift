//
//  Author.swift
//  GitbubAPI
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation

struct Author: Decodable {
    let username: String
    let avatarUrl: String
    
    enum AuthorKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AuthorKeys.self)
        
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}

/*
import Foundation
import SwiftyJSON

struct Author{
    var username: String?
    var avatarUrl: String?
    
    static func with(json: JSON) -> Author? {
        var aut = Author()
        if json["username"].exists() {
            aut.username = json["username"].string
        }
        if json["avatar_url"].exists() {
            aut.avatarUrl = json["avatar_url"].string
        }
        
        return aut
    }
}
 */
