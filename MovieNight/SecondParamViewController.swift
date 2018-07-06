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
    var actors: [Result] = []
    var chosenActors: [Result] = []
    
    
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
        chosenActors.append(self.actors[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "bubble-empty")!
        
        //let indexToRemove = chosenActors.index(of: )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "proceedToMainSegue":
            let vc = segue.destination as! MainViewController
            vc.chosenActors = chosenActors
        default:
            return
        }
    }
    
}
