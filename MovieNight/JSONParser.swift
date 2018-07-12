//
//  JSONParser.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import Foundation

//  Genre  decoding
struct Genre: Codable, Equatable {
    var name: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}


struct AllGenres: Codable {
    let genres: [Genre]
}


// Popular actor decoding
struct Result: Codable, Equatable {
    var name: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

struct AllResults: Codable {
    let results: [Result]
}


// Final match
struct FinalMatch: Codable, Equatable {
    var title: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
    }
}

struct FinalMatches: Codable {
    let results: [FinalMatch]
}






