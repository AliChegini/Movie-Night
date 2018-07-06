//
//  MovieNightClient.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import Foundation

class MovieNightAPIClient {
    
    lazy var genreURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=f0d4d14932ab901d6435839be5924d52&language=en-US")!
    }()
    
    lazy var actorURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/person/popular?api_key=f0d4d14932ab901d6435839be5924d52&language=en-US&page=1")!
    }()
    
    lazy var baseDiscoveryURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=f0d4d14932ab901d6435839be5924d52&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")!
    }()
    
    
    let downloader = JSONDownloader()
    
    // Get genres
    func getGenres(completionHandler completion: @escaping (Data?, MovieNightError?) -> Void) {
        let request = URLRequest(url: genreURL)
        print(request)
        
        let task = downloader.dataTask(with: request) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    // Get actors
    func getActors(completionHandler completion: @escaping (Data?, MovieNightError?) -> Void) {
        let request = URLRequest(url: actorURL)
        print(request)
        
        let task = downloader.dataTask(with: request) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    
    // Get Discovery
    // function to get parameter and use relative to base for constructin a URL
    func callDiscovery() {
        
    }
    
    
    
}


