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
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // todo: load the movie details...
        if let movie = movie {
            moviePoster.image = movie.poster
            titleTextField.text = movie.title
            yearTextField.text = movie.year
            ratingTextField.text = movie.rating
            plotTextView.text = movie.plot
        }

    }
}
