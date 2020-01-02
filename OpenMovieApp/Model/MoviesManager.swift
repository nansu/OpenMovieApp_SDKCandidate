//
//  MoviesManager.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import Foundation
class MoviesManager {
    private lazy var movies = loadMovies()
    
    var movieCount: Int {
        return movies.count
    }
    
    private func loadMovies() -> [Movie] {
        return sampleMovies()
    }
    
    func getMovie(at index:Int) -> Movie {
        return movies[index]
    }
    
    private func sampleMovies() -> [Movie] {
        return [
            Movie(title: "title 1", year: "1990", plot: "a plot", rating: "R"),
            Movie(title: "title 2", year: "1987", plot: "a plot", rating: "A"),
            Movie(title: "title 3", year: "1988", plot: "a plot", rating: "B"),
            Movie(title: "title 4", year: "11991", plot: "a plot", rating: "C"),
            Movie(title: "title 5", year: "1992", plot: "a plot", rating: "D")
        ]
    }
}
