//
//  MobieDetailViewController.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var plotTextView: UITextView!

    var movieService:MovieService = OpenMovieService()
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            movieService.getMovieDetails(title: movie.title, completionHandler: { (data, error) in
                    if error != nil {
                        return
                    } else {
                        self.moviePoster.image = movie.poster
                        self.titleTextField.text = movie.title
                        self.yearTextField.text = movie.year
                        self.ratingTextField.text = data["rating"]
                        self.plotTextView.text = data["plot"]
                    }
            })
        }
    }
}
