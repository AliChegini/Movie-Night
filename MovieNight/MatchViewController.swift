//
//  MatchViewController.swift
//  MovieNight
//
//  Created by Ehsan on 25/09/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    
    var watcherOne: WatcherOneFullPackage? = nil
    var watcherTwo: WatcherTwoFullPackage? = nil
    
    var allMatches: [FinalMatch] = []

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
        
        
        guard let finalGenres = client.findGenreMatches(watcherOne: watcherOne, watcherTwo: watcherTwo) else {
            return
        }
        
        guard let finalActors = client.findActorsMatches(watcherOne: watcherOne, watcherTwo: watcherTwo) else {
            return
        }
        
        client.callDiscovery(genres: finalGenres, actors: finalActors) { data, error in
            let decoder = JSONDecoder()
            guard let data = data else {
                print("data is empty")
                return
            }
            
            let finalMatches = try? decoder.decode(FinalMatches.self, from: data)
            if let finalMatchesUnwrapped = finalMatches {
                for match in finalMatchesUnwrapped.results {
                    let matchObject = FinalMatch(title: match.title, id: match.id)
                    self.allMatches.append(matchObject)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "matchPreferencesSegue":
            if let fvc = segue.destination as? FinalResultViewController {
                fvc.allMatches = allMatches
            }
        default:
            return
        }
    }
    
}
