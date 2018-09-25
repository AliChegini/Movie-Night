//
//  FinalResultViewController.swift
//  MovieNight
//
//  Created by Ehsan on 03/09/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class FinalResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allMatches: [FinalMatch] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        self.title = "Final Result"
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
