//
//  ServiceManager.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 26.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

struct ServiceManager {
    
    let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=10f8ed8f46cea198f9dd2129bbcd37a8"
   
    func getPopularMovies() -> Observable<Resource>  {
        
       return Observable.create { observer in
            observer.onNext(Resource.loading())
            
            if let url = URL(string: url) {
                
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: url) { data, response, error in
                    
                    if error != nil {
                        observer.onNext(Resource.failure(error: error!.localizedDescription))
                    }
                    else {
                        if let safeData = data {
                            let decoder = JSONDecoder()
                            
                            do{
                                let decodedData = try decoder.decode(MovieResponse.self, from: safeData)
                                observer.onNext(Resource.success(data: decodedData))
                                
                            }catch{
                                observer.onNext(Resource.failure(error: error.localizedDescription))
                            }
                            
                        }
                        
                    }
                }.resume()
            }
          return Disposables.create {
        
           }
       }
        
    
    }
}
