//
//  Repository.swift
//  GitbubAPI
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//
import Foundation

struct Repository: Decodable {
    let name: String
    let description: String
    let starsCount: Int
    let owner: Author
    enum RepositoryKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case starsCount = "stargazers_count"
        case owner = "owner"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepositoryKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.starsCount = try container.decode(Int.self, forKey: .starsCount)
        self.owner = try container.decode(Author.self, forKey: .owner)
    }
}
/*
import SwiftyJSON

struct Repository {
    var name: String?
    var description: String?
    var starsCount: Int = 0
    var repositoryUrl: String?
    var owner: Author?
    
    static func with(json: JSON) -> Repository? {
        var rep = Repository()
        if json["name"].exists() {
            rep.name = json["name"].string
        }
        if json["description"].exists() {
            rep.description = json["description"].string
        }
        if json["stargazers_count"].exists() {
            rep.starsCount = json["stargazers_count"].intValue
        }
        if json["owner"].exists() {
            if let aut = Author.with(json: json["owner"]){
                rep.owner = aut
            }
        }
        return rep
    }
    
}
 */
