//
//  ViewController.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    var movieService:MovieService = OpenMovieService()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        movieService.getMovie { (movie, error) in
            if error != nil {
                //deal with error
                return
            } else {
                print (movie)
            }
        }
    }


}

