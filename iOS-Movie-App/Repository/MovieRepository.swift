//
//  MovieRepository.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 28.05.2022.
//

import Foundation

class MovieRepository {
    
    let serviceManager = ServiceManager()
    var resource:Resource = Resource.loading()
    
    func getPopularMovies() {
    
        resource = serviceManager.getPopularMovies()
        
    }
    
    
}
