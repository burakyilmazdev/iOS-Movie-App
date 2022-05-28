//
//  MovieResponse.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 27.05.2022.
//

import Foundation

struct MovieResponse: Decodable {
    
    let page: Int
    let results: Array<Movie>
    let total_pages: Int
    let total_results: Int
    
    
}
