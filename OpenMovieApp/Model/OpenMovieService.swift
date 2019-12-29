//
//  OpenMovileService.swift
//  OpenMovieApp
//
//  Created by Nan Su on 12/29/19.
//  Copyright © 2019 Nan Su. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol MovieService {
    func getMovie(completionHandler: @escaping (Movie?, Error?) -> Void)
    func cancel()
}

class OpenMovieService:NSObject, MovieService, URLSessionDelegate {
    let omAPIKey = "a9d25578"
    let omUrl = "https://www.omdbapi.com/"
    var task:URLSessionTask?
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    func getMovie(completionHandler: @escaping (Movie?, Error?) -> Void) {
        // generate url
        guard var components = URLComponents(string: omUrl) else { return }
        components.queryItems = [URLQueryItem(name: "apikey", value: omAPIKey), URLQueryItem(name: "t", value: "little")]
        guard let url = components.url else { return }
        
        // generate request
        let request = URLRequest(url: url)
        
        task = session.dataTask(with: request) { (data, response, error) in
            if let error=error {
                completionHandler(nil, error)
            }
            guard let data = data else { return }
            self.parseSwiftyJSON(data: data, completionHandler: completionHandler)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    private func parseSwiftyJSON(data:Data, completionHandler: @escaping (Movie?, Error?) -> Void) {
        do {
            let dataAsJSON = try JSON(data: data)
            // movie always come back as a single object...
            if let title = dataAsJSON["Title"].string,
                let year = dataAsJSON["Year"].string,
                let plot = dataAsJSON["Plot"].string,
                let rating = dataAsJSON["Rated"].string,
                let poster = dataAsJSON["Poster"].string{
                let movie = Movie(title: title, year: year, plot: plot, rating: rating)
                loadPoster(movie: movie, posterUrl: poster, completionHandler: completionHandler)
            }
      } catch let error as NSError {
          completionHandler(nil, error)
          return
      }
      completionHandler(nil, nil)
    }
    
    func loadPoster(movie:Movie, posterUrl:String, completionHandler: @escaping (Movie?, Error?) -> Void) {
        var movie = movie
        guard let url = URL(string: posterUrl) else {return}
        task = session.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL,
            let data = try? Data(contentsOf: tempURL),
            let image = UIImage(data: data) {
            movie.poster = image
            }
            completionHandler(movie,error)
        }
        task?.resume()
    }
}
