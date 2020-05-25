//
//  StubJson.swift
//  GitbubAPITests
//
//  Created by Adi Wibowo on 25/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation

struct StubJson {
    static func getData() -> Data {
        return self.jsonString().data(using: .utf8)!
    }
    static func jsonString() -> String {
        return """
        {
            "name": "awesome-ios",
            "owner": {
                "login": "vsouza",
                "avatar_url": "https://avatars2.githubusercontent.com/u/484656?v=4",
            },
            "description": "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects ",
            "stargazers_count": 32648
        }
        """
    }
}

