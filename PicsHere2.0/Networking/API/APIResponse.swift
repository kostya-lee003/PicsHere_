//
//  API.swift
//  PicsHere2.0
//
//  Created by Kostya Lee on 02/01/22.
//

import Foundation

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let small: String
}
