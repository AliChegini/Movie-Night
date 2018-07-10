//
//  Model.swift
//  MovieNight
//
//  Created by Ehsan on 08/07/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import Foundation


struct FullPackage {
    var watcherNumber: Int
    var genres: [Genre]?
    var actors: [Result]?
}


struct WatcherOneFullPackage: Codable {
    var genres: [Genre]?
    var actors: [Result]?
}


struct WatcherTwoFullPackage: Codable {
    var genres: [Genre]?
    var actors: [Result]?
}










