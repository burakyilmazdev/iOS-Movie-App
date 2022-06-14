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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPopularMovies() -> Observable<Resource> {
       return serviceManager.getPopularMovies()

    }
    
    func getFavoritesMovies() -> Observable<[MovieEntity]>{
        
        return Observable.create { observer in
            do{
                try observer.onNext(self.context.fetch(MovieEntity.fetchRequest()))
            }catch{
                
            }
            
            return Disposables.create{
                
            }
        }
        
        
        
    }
    
    
    
    
    
}
