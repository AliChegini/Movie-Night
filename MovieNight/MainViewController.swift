//
//  MainViewController.swift
//  MovieNight
//
//  Created by Ehsan on 06/07/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    
    @IBOutlet weak var button: UIButton!
    
    
    var chosenActors: [Result]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        print(chosenActors)
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
    
}
