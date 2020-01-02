//
//  Movie.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import UIKit

struct Movie {
    static let defaultPoster = UIImage(named: "imageIcon.png")
    var title:String
    var year:String
    var plot:String?
    var rating:String?
    
    private var image:UIImage? = nil
    
    var poster:UIImage {
        get {
            return image ?? Movie.defaultPoster!
        }
        set {
            image = newValue
        }
    }
    
    init(title:String, year:String, plot:String = "",
         rating:String = "", poster:UIImage? = nil) {
        self.title = title
        self.year = year
        self.plot = plot
        self.rating = rating
        self.image = poster
    }
}
