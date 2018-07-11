//
//  ResultViewController.swift
//  MovieNight
//
//  Created by Ehsan on 10/07/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class ResultViewController: UITableViewController {
    
    var watcherOne: WatcherOneFullPackage? = nil
    var watcherTwo: WatcherTwoFullPackage? = nil
    
    let client = MovieNightAPIClient()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Reading User Defaults
        if let data = UserDefaults.standard.value(forKey: "watcherOne") as? Data {
            let decodedWatcherOne = try? PropertyListDecoder().decode(WatcherOneFullPackage.self, from: data)
            watcherOne = decodedWatcherOne
        }
        
        if let data = UserDefaults.standard.value(forKey: "watcherTwo") as? Data {
            let decodedWatcherTwo = try? PropertyListDecoder().decode(WatcherTwoFullPackage.self, from: data)
            watcherTwo = decodedWatcherTwo
        }
        
        
        let finalGenres = client.findGenreMatches(watcherOne: watcherOne, watcherTwo: watcherTwo)
        let finalActors = client.findActorsMatches(watcherOne: watcherOne, watcherTwo: watcherTwo)
        
        client.callDiscovery(genres: finalGenres!, actors: finalActors!) { data, error in
            
        }
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
