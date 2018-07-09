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
    var watcherOne: WatcherOneFullPackage? = nil
    var watcherTwo: WatcherTwoFullPackage? = nil
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    
    var fullPack: FullPackage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if fullPack?.watcherNumber == 1 {
            watcherOne = WatcherOneFullPackage(genres: fullPack?.genres, actors: fullPack?.actors)
        } else if fullPack?.watcherNumber == 2 {
            watcherTwo = WatcherTwoFullPackage(genres: fullPack?.genres, actors: fullPack?.actors)
        }
        print("--------------")
        print(watcherOne)
        print("--------------")
        print(watcherTwo)
        print("--------------")
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
        let vc = segue.destination as! FirstParamViewController
        switch segue.identifier {
        case "proceedToWatcherOne":
            vc.watcherNumber = 1
        case "proceedToWatcherTwo":
            vc.watcherNumber = 2
        default:
            return
        }
    }
    
    
}
