//
//  JSONDownloader.swift
//  MovieNight
//
//  Created by Ehsan on 29/06/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import Foundation
import UIKit

class JSONDownloader {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    func dataTask(with request: URLRequest, completionHandler completion: @escaping (Data?, MovieNightError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            // Alert the user for connection related errors
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    let alert = UIAlertController(title: "Error", message: "No Internet Connection \nPlease try again later...", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    //alert.presentInOwnWindow(animated: true, completion: nil)
                case .networkConnectionLost:
                    let alert = UIAlertController(title: "Error", message: "Connection Lost \nPlease try again later...", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    //alert.presentInOwnWindow(animated: true, completion: nil)
                default: break
                }
            }
            
            // Convert to HTTP Response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        return task
        
    }
    
    
}
