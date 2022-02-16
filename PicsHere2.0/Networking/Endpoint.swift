//
//  Endpoint.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 02/01/22.
//

import Foundation

struct Endpoint {
    var path: String
    static let client_id: String = "knArbFBXImVv1Q53ZXn9VRKwoyGhqVbscFkAOcAzlcE"
    var url: URL? {
        URL(string: "https://api.unsplash.com/\(path)")
    }
}

extension Endpoint {
    
    static var recommendations: Self {
        Endpoint(path: "photos/random&client_id=\(client_id)")
    }

    static func search(for query: String) -> Self {
        Endpoint(path: "search/photos?page=1&per_page=30&query=\(query)&client_id=\(client_id)")
    }
}
