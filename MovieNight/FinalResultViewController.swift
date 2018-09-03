//
//  FinalResultViewController.swift
//  MovieNight
//
//  Created by Ehsan on 03/09/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class FinalResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var watcherOne: WatcherOneFullPackage? = nil
    var watcherTwo: WatcherTwoFullPackage? = nil
    
    let client = MovieNightAPIClient()
    
    var allMatches: [FinalMatch] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        self.title = "Final Result"
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMatches.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCustomCell
        
        cell.myCellLabel.text = allMatches[indexPath.row].title
        
        return cell
    }
    
    
}
