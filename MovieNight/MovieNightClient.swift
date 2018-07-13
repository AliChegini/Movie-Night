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
        //print(request)
        
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
        //print(request)
        
        let task = downloader.dataTask(with: request) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    // function to find matches for Genres
    // In case if users don't have shared Genres, only actors will be counted
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
    
    // function to find matches for Actors
    // In case if users don't have shared Actors, only genres will be counted
    func findActorsMatches(watcherOne: WatcherOneFullPackage?, watcherTwo: WatcherTwoFullPackage?) -> [Actor]? {
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
        
        var finalActors: [Actor] = []
        
        // Using filter to find matches in two arrays
        finalActors = watcherOneActorsUnwrapped.filter { (actor) -> Bool in
            return watcherTwoActorsUnwrapped.contains(actor)
        }
        return finalActors
    }
    
    
    // function to construct a string phrase
    func generatePhrase(array: [GenreAndActor], phraseType: PhraseType) -> String {
        var phrase = phraseType.rawValue
        
        // counter to track the last iteration
        let arraySize = array.count
        var counter = 0
        
        if arraySize != 0 {
            for element in array {
                if arraySize - counter > 1 {
                    // comma, is equal to AND operator between values
                    phrase += "\(element.id!),"
                } else if arraySize - counter == 1 {    // branch to cover last itteration
                    phrase += "\(element.id!)"
                }
                counter += 1
            }
        }
        return phrase
    }
    
    
    // Discovery function
    func callDiscovery(genres: [Genre], actors: [Actor], completionHandler completion: @escaping (Data?, MovieNightError?) -> Void) {
        var phrase = ""
        
        if genres.count != 0 {
            phrase += generatePhrase(array: genres, phraseType: .genres)
        }
        
        if actors.count != 0 {
            phrase += generatePhrase(array: actors, phraseType: .actors)
        }
        
        // encoding the raw url to easily append string to end of it
        var escapedRawURL = baseDiscoveryURL.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        escapedRawURL!.append(phrase)
        
        guard let url = URL(string: escapedRawURL!) else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
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


