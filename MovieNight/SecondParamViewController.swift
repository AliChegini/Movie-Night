//
//  SecondParamViewController.swift
//  MovieNight
//
//  Created by Ehsan on 02/07/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class SecondParamViewController: UITableViewController {

    let client = MovieNightAPIClient()
    // array to hold all actors received form FirstParamViewController
    var actors: [Actor]? = nil
    var actorsUnwrapped : [Actor] = []
    
    var selectedActors: [Actor] = []
    var deselectedActors: [Actor] = []
    // array after filtering deselected
    var chosenActors: [Actor] = []
    

    // recieving from FirstParam
    var chosenGenres: [Genre]? = []
    var watcherNumber: Int?
    var watcherNumberUnwrapped: Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Actors/Actresses"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if let allActors = actors {
            actorsUnwrapped = allActors
        }
        
        if let number = watcherNumber {
            watcherNumberUnwrapped = number
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorsUnwrapped.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = actorsUnwrapped[indexPath.row].name
        
        let emptyBubble: UIImage = UIImage(named: "bubble-empty")!
        cell.imageView?.image = emptyBubble
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-selected")!
        selectedActors.append(actorsUnwrapped[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-empty")!
        deselectedActors.append(actorsUnwrapped[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proceedToMainSegue":
            chosenActors = selectedActors.filter { !deselectedActors.contains($0)  }
            
            let vc = segue.destination as! MainViewController
            
            // Constructing a full package and sending it to main
            // Full package has both criteria chosed by user inclusing watcher number
            let fullPack = FullPackage(watcherNumber: watcherNumberUnwrapped, genres: chosenGenres, actors: chosenActors)
            
            vc.fullPack = fullPack
            print("sending to main")
        default:
            return
        }
    }
    
}
