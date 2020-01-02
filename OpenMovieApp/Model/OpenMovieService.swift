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
    func getMovies(search:String, completionHandler: @escaping ([Movie]?, Error?) -> Void)
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
    
    func getMovies(search:String, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        // generate url
        guard var components = URLComponents(string: omUrl) else { return }
        components.queryItems = [URLQueryItem(name: "apikey", value: omAPIKey), URLQueryItem(name: "s", value: search)]
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
    
    private func parseSwiftyJSON(data:Data, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        do {
            var moviesReturned = [Movie]()
            let dataAsJSON = try JSON(data: data)
//            print(dataAsJSON)
            for item in dataAsJSON["Search"].arrayValue {
                if let title = item["Title"].string,
                    let year = item["Year"].string,
                    let poster = item["Poster"].string{
                    guard let url = URL(string: poster) else {return}
                    guard let data = try? Data(contentsOf: url) else { return }
                    let image = UIImage(data: data)
                    let movie = Movie(title: title, year: year, poster: image)
//                    loadPoster(movie: movie, posterUrl: poster, completionHandler: completionHandler)
                    moviesReturned.append(movie)
                }
            }
            completionHandler(moviesReturned, nil)
      } catch let error as NSError {
          completionHandler(nil, error)
          return
      }
//      completionHandler(nil, nil)
    }
    
    func loadPoster(movie:Movie, posterUrl:String, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        var movie = movie
        guard let url = URL(string: posterUrl) else {return}
        task = session.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL,
            let data = try? Data(contentsOf: tempURL),
            let image = UIImage(data: data) {
            movie.poster = image
            }
            //completionHandler(movie,error)
        }
        task?.resume()
    }
}
