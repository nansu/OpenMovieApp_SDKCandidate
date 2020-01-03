//
//  MoviesManagerTests.swift
//  OpenMovieAppTests
//
//  Created by Nan Su on 1/3/20.
//  Copyright © 2020 Nan Su. All rights reserved.
//

import XCTest
@testable import OpenMovieApp

class MoviesManagerTests: XCTestCase {

    var moviesManager:MoviesManager!
    
    override func setUp() {
        moviesManager = MoviesManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetMovieWithSearchFilter() {
        moviesManager.searchFilter = "test"
        let movie = moviesManager.getMovie(at: 0)
        XCTAssert(movie?.title == "title 1")
        XCTAssert(movie?.year == "1990")
        XCTAssert(movie?.rating == "R")
        XCTAssert(movie?.plot == "a plot")
    }
    
    func testGetMovieWithoutSearchFilter() {
        let movie = moviesManager.getMovie(at: 0)
        XCTAssert(movie == nil)
    }
}
