//
//  Movie.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 27.05.2022.
//

import Foundation


struct Movie: Decodable{
    
    let title:String
    let overview: String
    let backdrop_path: String
    let poster_path: String
    
}
