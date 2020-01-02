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
    private var filteredMovies:[Movie] = []
    var movieService:MovieService = OpenMovieService()
    
    var movieCount: Int {
        return searchFilter.isEmpty ? 0 : movies.count
    }
    
    private func loadMovies() -> [Movie] {
        return sampleMovies()
    }
    
    var searchFilter:String = "" {
        didSet {
            // todo: get movies list
            filter()
        }
    }
    
    func getMovie(at index:Int) -> Movie? {
        return searchFilter.isEmpty ? nil : movies[index]
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
    
    func filter() {
        movieService.getMovies(search: searchFilter.localizedLowercase, completionHandler: { (movies, error) in
            if error != nil {
                //deal with error
                return
            } else {
                print("### \(movies)")
                self.movies = movies ?? []
            }
        })
    }
    
}
