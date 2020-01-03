//
//  MoviesManager.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import Foundation

protocol MoviesManagerDelegate:AnyObject {
    func fetched()
}

class MoviesManager {
    private lazy var movies = loadMovies()
    private var filteredMovies:[Movie] = []
    var movieService:MovieService = OpenMovieService()
    weak var delegate:MoviesManagerDelegate?
    
    var movieCount: Int {
        return searchFilter.isEmpty ? 0 : movies.count
    }
    
    private func loadMovies() -> [Movie] {
        return loadPlaceHolderMovies()
    }
    
    var searchFilter:String = "" {
        didSet {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fetch), userInfo: nil, repeats: false)
        }
    }
    
    var timer:Timer?
    
    func getMovie(at index:Int) -> Movie? {
        if index < movies.count {
            return searchFilter.isEmpty ? nil : movies[index]
        }
        return nil
    }
    
    private func loadPlaceHolderMovies() -> [Movie] {
        return [
            Movie(title: "title 1", year: "1990", plot: "a plot", rating: "R"),
            Movie(title: "title 2", year: "1987", plot: "a plot", rating: "A"),
            Movie(title: "title 3", year: "1988", plot: "a plot", rating: "B"),
            Movie(title: "title 4", year: "1991", plot: "a plot", rating: "C"),
            Movie(title: "title 5", year: "1992", plot: "a plot", rating: "D")
        ]
    }
    
    @objc func fetch() {
        movieService.getMovies(search: searchFilter.localizedLowercase, completionHandler: { (movies, error) in
            if error != nil {
                return
            } else {
                self.movies = movies ?? []
                // print("load in manager \(movies?.count)")
                self.delegate?.fetched()
            }
        })
    }
}
