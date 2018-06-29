//
//  ViewController.swift
//  MovieNight
//
//  Created by Ehsan on 26/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var watcherOne: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var imageOne: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func button1Pressed(_ sender: UIButton) {
        imageOne.image = #imageLiteral(resourceName: "bubble-selected")
        button1.setTitle("Ready!", for: .normal)
    }
    

}

