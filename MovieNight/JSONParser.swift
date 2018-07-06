//
//  JSONParser.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import Foundation

//  Genre  decoding
struct Genre: Decodable {
    var name: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}


struct AllGenres: Decodable {
    let genres: [Genre]
}


// Popular decoding
struct Result: Codable, Equatable {
    var name: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

struct AllResults: Decodable {
    let results: [Result]
}








