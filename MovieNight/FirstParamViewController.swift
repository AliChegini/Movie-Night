//
//  WatcherOneViewController.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class FirstParamViewController: UITableViewController {

    // Array to receive genres from main view
    var allTheGenres: [Genre]? = nil
    var allTheGenresUnwrapped: [Genre] = []
    
    var chosenGenres: [Genre] = []  // array to hold genres after selection process
    
    var selectedGenres: [Genre] = []
    var deselectedGenres: [Genre] = []
    
    var watcherNumber: Int?
    
    let client = MovieNightAPIClient()
    // Array to hold actors
    var actors: [Actor] = []   // all actors
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Genres"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if let genres = allTheGenres {
            allTheGenresUnwrapped = genres
        }
        
        // asynch call to fetch actors for SecondViewController
        client.getActors() { bucket, error in
            let decoder = JSONDecoder()
            guard let bucket = bucket else {
                print("actor is empty")
                return
            }
            
            let responseBucket = try? decoder.decode(AllResults.self, from: bucket)
            
            if let responseBucketUnwrapped = responseBucket {
                for response in responseBucketUnwrapped.results {
                    let actorObject = Actor(name: response.name, id: response.id)
                    self.actors.append(actorObject)
                }
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheGenresUnwrapped.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allTheGenresUnwrapped[indexPath.row].name
        
        let emptyBubble: UIImage = UIImage(named: "bubble-empty")!
        cell.imageView?.image = emptyBubble
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-selected")!
        selectedGenres.append(allTheGenresUnwrapped[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-empty")!
        deselectedGenres.append(allTheGenresUnwrapped[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proceedToActorSegue":
            chosenGenres = selectedGenres.filter { !deselectedGenres.contains($0)  }
            let vc = segue.destination as! SecondParamViewController
            // Sending data to SecondParamViewController
            vc.chosenGenres = chosenGenres
            vc.watcherNumber = watcherNumber
            vc.actors = actors
        default:
            return
        }
    }

}



