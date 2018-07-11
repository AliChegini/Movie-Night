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
    
    
    func findGenreMatches(watcherOne: WatcherOneFullPackage?, watcherTwo: WatcherTwoFullPackage?) -> [Genre]? {
        guard let watcherOneUnwrapped = watcherOne else {
            return nil
        }
        
        guard let watcherTwoUnwrapped = watcherTwo else {
            return nil
        }
        
        guard let watcherOneGenresUnwrapped = watcherOneUnwrapped.genres else {
            return nil
        }
        
        
        guard let watcherTwoGenresUnwrapped = watcherTwoUnwrapped.genres else {
            return nil
        }
        
        
        var finalGenres: [Genre] = []
        
        // Using filter to find matches in two arrays
        finalGenres = watcherOneGenresUnwrapped.filter { (genre) -> Bool in
            return watcherTwoGenresUnwrapped.contains(genre)
        }
        
        return finalGenres
        
    }
    
    
    func findActorsMatches(watcherOne: WatcherOneFullPackage?, watcherTwo: WatcherTwoFullPackage?) -> [Result]? {
        guard let watcherOneUnwrapped = watcherOne else {
            return nil
        }
        
        guard let watcherTwoUnwrapped = watcherTwo else {
            return nil
        }
        
        guard let watcherOneActorsUnwrapped = watcherOneUnwrapped.actors else {
            return nil
        }
        
        guard let watcherTwoActorsUnwrapped = watcherTwoUnwrapped.actors else {
            return nil
        }
        
        var finalActors: [Result] = []
        
        // Using filter to find matches in two arrays
        finalActors = watcherOneActorsUnwrapped.filter { (actor) -> Bool in
            return watcherTwoActorsUnwrapped.contains(actor)
        }
        
        return finalActors
        
    }
    
    
    // Get Discovery
    // function to get parameter and use relative to base for constructin a URL
    func callDiscovery(genres: [Genre], actors: [Result], completionHandler completion: @escaping (Data?, MovieNightError?) -> Void) {
        var phrase = ""
        if genres.count != 0 {
            for genre in genres {
                phrase += "\(genre.id!)|"
            }
            print(phrase)
        }
        
        guard let url = URL(string: "", relativeTo: baseDiscoveryURL) else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
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
    
    
    
}


