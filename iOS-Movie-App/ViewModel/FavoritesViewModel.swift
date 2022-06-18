//
//  FavoritesViewModel.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 10.06.2022.
//

import Foundation
import CoreData
import UIKit
import RxSwift
import Kingfisher

class FavoritesViewModel {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let movieRepository = MovieRepository()
    
    
    func saveToDatabase(favoriteMovie:Movie){
        
        let newFavoriteMovie = MovieEntity(context: context)
        newFavoriteMovie.title = favoriteMovie.title
        newFavoriteMovie.overview = favoriteMovie.overview
        newFavoriteMovie.poster_path = favoriteMovie.poster_path
        newFavoriteMovie.backdrop_path = favoriteMovie.backdrop_path
        
        do{
            try context.save()
        }catch{
            
        }
        
    }
    
    func fetchFavoritesMovies() -> Observable<[MovieEntity]>{
            return movieRepository.getFavoritesMovies()
        }
    
    
    func scaleAndShowImage(url:URL,imageView: UIImageView,size:CGSize) {
    
        var scaledImage = UIImage()
        
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                let image = value.image
                scaledImage = UIImage.scaleImage(img: image, size: size)
                imageView.image = scaledImage
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
    }
    
    func delete(movieToRemove:MovieEntity){
        
        self.context.delete(movieToRemove)
        
        do{
            try self.context.save()
        }catch{
            print("error in delete")
        }
        
        
    }
    
    
    
}
