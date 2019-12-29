//
//  Movie.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import UIKit

struct Movie {
    var title:String
    var year:String
    var plot:String
    var rating:String
    var poster:UIImage?
    
    private var image:UIImage? = nil
    
    init(title:String, year:String, plot:String,
         rating:String, poster:UIImage? = nil) {
        self.title = title
        self.year = year
        self.plot = plot
        self.rating = rating
        self.image = poster
    }
}
