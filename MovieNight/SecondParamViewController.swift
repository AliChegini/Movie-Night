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
    var actors: [Result] = []   // all actors
    var selectedActors: [Result] = []
    var deselectedActors: [Result] = []
    // array after filtering deselected
    var chosenActors: [Result] = []
    

    // recieving from FirstParam
    var chosenGenres: [Genre]? = []
    var watcherNumber: Int?
    //var fullPack: [FullPackage] = []    // array to send to mainView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Actors/Actresses"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        client.getActors() { bucket, error in
            let decoder = JSONDecoder()
            guard let bucket = bucket else {
                print("actor is empty")
                return
            }
            
            let responseBucket = try? decoder.decode(AllResults.self, from: bucket)
            
            if let responseBucketUnwrapped = responseBucket {
                for response in responseBucketUnwrapped.results {
                    let actorObject = Result(name: response.name, id: response.id)
                    self.actors.append(actorObject)
                }
            }
            print(self.actors.count)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actors.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.actors[indexPath.row].name
        
        let emptyBubble: UIImage = UIImage(named: "bubble-empty")!
        cell.imageView?.image = emptyBubble
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-selected")!
        selectedActors.append(self.actors[indexPath.row])
        print("selected")
        print(selectedActors)
        print("---")
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-empty")!
        
        deselectedActors.append(self.actors[indexPath.row])
        print("deselected")
        print(deselectedActors)
        print("---")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proceedToMainSegue":
            chosenActors = selectedActors.filter { !deselectedActors.contains($0)  }
            let vc = segue.destination as! MainViewController
            
            let fullPack = FullPackage(watcherNumber: watcherNumber!, genres: chosenGenres, actors: chosenActors)
            
            vc.fullPack = fullPack
            print("sending to main")
        default:
            return
        }
    }
    
}
