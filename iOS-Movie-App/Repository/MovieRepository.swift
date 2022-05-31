//
//  MovieRepository.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 28.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

class MovieRepository {
    
    private let serviceManager = ServiceManager()
    
    func getPopularMovies() -> Observable<Resource> {
       return serviceManager.getPopularMovies()

    }
    
    
    
    
    
}
