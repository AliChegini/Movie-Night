//
//  Extension.swift
//  MovieNight
//
//  Created by Ehsan on 03/09/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit


// extension to alert the user for connection related errors from JSONDownloader
extension UIAlertController {
    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootVC.present(self, animated: animated, completion: completion)
    }
}


extension UITableViewController {
    func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Oops, something went wrong\n Please try again...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}



