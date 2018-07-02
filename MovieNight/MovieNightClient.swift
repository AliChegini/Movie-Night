//
//  MovieNightClient.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import Foundation

class MovieNightAPIClient {
    
    lazy var baseURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=f0d4d14932ab901d6435839be5924d52&language=en-US")!
    }()
    
    let downloader = JSONDownloader()
    
    func getGenress(completionHandler completion: @escaping (Data?, MovieNightError?) -> Void) {
        let request = URLRequest(url: baseURL)
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


