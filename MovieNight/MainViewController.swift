//
//  MainViewController.swift
//  MovieNight
//
//  Created by Ehsan on 06/07/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var watcherNumber: Int = 0
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var fullPack: FullPackage?
    
    let client = MovieNightAPIClient()
    
    var allTheGenres: [Genre] = []
    var actors: [Actor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Reseting the defaults at launch
        if UIApplication.shared.applicationState.rawValue == 1 {
            UserDefaults.standard.removeObject(forKey: "watcherOne")
            UserDefaults.standard.removeObject(forKey: "watcherTwo")
        }
        
        
        // Checking which watcher provided preferences
        if fullPack?.watcherNumber == 1 {
            let watcherOne = WatcherOneFullPackage(genres: fullPack?.genres, actors: fullPack?.actors)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(watcherOne), forKey:"watcherOne")
            
        } else if fullPack?.watcherNumber == 2 {
            let watcherTwo = WatcherTwoFullPackage(genres: fullPack?.genres, actors: fullPack?.actors)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(watcherTwo), forKey:"watcherTwo")
            
        }
        
        // Asynch call to get all genres to pass it to other view
        client.getGenres() { genres, error in
            let decoder = JSONDecoder()
            guard let genres = genres else {
                print("genre is empty")
                return
            }
            
            let allGenres = try? decoder.decode(AllGenres.self, from: genres)
            if let allGenresUnwrapped = allGenres {
                for genre in allGenresUnwrapped.genres {
                    let genreObject = Genre(name: genre.name, id: genre.id)
                    self.allTheGenres.append(genreObject)
                }
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func watcherOne(_ sender: UIButton) {
        watcherNumber = 1
    }
    
    
    @IBAction func watcherTwo(_ sender: UIButton) {
        watcherNumber = 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proceedToWatcherOne":
            if let vc = segue.destination as? FirstParamViewController {
                vc.watcherNumber = 1
                vc.allTheGenres = allTheGenres
            }
        case "proceedToWatcherTwo":
            if let vc = segue.destination as? FirstParamViewController {
                vc.watcherNumber = 2
                vc.allTheGenres = allTheGenres
            }
        default:
            return
        }
        
    }
    
}


