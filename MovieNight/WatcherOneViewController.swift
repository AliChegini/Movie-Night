//
//  WatcherOneViewController.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class WatcherOneViewController: UITableViewController {

    let client = MovieNightAPIClient()
    var allTheGenres: [Genre] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Genres"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        client.getGenress() { genres, error in
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
            print(self.allTheGenres.count)
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTheGenres.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.allTheGenres[indexPath.row].name
        return cell
    }


}
