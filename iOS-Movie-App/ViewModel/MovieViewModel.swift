//
//  movieViewModel.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 28.05.2022.
//

import Foundation
import RxSwift

class MovieViewModel {
    
    private let movieRepository = MovieRepository()
    
    func getMovies() -> Observable<Resource>
    {
        print("view model")
        let movies = movieRepository.getPopularMovies()
        return movies
    }
    
    
}
