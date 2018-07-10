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
    
    var finalGenres: [Int] = []
    var finalActors: [Int] = []

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
        
        
        guard let watcherOneUnwrapped = watcherOne else {
            return
        }
        
        guard let watcherTwoUnwrapped = watcherTwo else {
            return
        }
        
        
        
        guard let watcherOneGenresUnwrapped = watcherOneUnwrapped.genres else {
            return
        }
        
        guard let watcherOneActorsUnwrapped = watcherOneUnwrapped.actors else {
            return
        }
        
        guard let watcherTwoGenresUnwrapped = watcherTwoUnwrapped.genres else {
            return
        }
        
        guard let watcherTwoActorsUnwrapped = watcherTwoUnwrapped.actors else {
            return
        }
        
        
        for a in watcherOneGenresUnwrapped {
            for b in watcherTwoGenresUnwrapped {
                if a.id == b.id {
                    finalGenres.append(a.id!)
                }
            }
        }
        
        
        for a in watcherOneActorsUnwrapped {
            for b in watcherTwoActorsUnwrapped {
                if a.id == b.id {
                    finalActors.append(a.id!)
                }
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
