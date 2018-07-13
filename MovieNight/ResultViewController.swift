//
//  ResultViewController.swift
//  MovieNight
//
//  Created by Ehsan on 10/07/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

// Result will only shown if there are matches between actors selected
// and Genre selected by both users
// In the case of no match alert will be shown to user to try again
class ResultViewController: UITableViewController {
    
    var watcherOne: WatcherOneFullPackage? = nil
    var watcherTwo: WatcherTwoFullPackage? = nil
    
    let client = MovieNightAPIClient()
    
    var allMatches: [FinalMatch] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Final Result"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if allMatches is empty, show alert
        if self.allMatches.count == 0 {
            let alert = UIAlertController(title: "Error", message: "No Matching Result \nPlease try again...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        return self.allMatches.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.allMatches[indexPath.row].title
        
        return cell
    }

    
}




