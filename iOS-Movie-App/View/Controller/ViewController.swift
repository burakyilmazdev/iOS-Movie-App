//
//  ViewController.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 25.05.2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    

    @IBOutlet weak var collectionViewIndicator: UIActivityIndicatorView!
    @IBOutlet weak var coverIndicator: UIActivityIndicatorView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var movieCollectionView: UICollectionView!

    
    let movieViewModel = MovieViewModel()
    private var bag = DisposeBag()
    var movieArray = [Movie]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        movieViewModel.getMovies().subscribe { Resource in
            
            switch Resource.element?.status{
                
            case .Success:
                print("success")
                DispatchQueue.main.async {
                    self.coverIndicator.isHidden = true
                    self.collectionViewIndicator.isHidden = true
                }

                for element in Resource.element!.data!.results {
                    self.movieArray.append(element)
                }
                
                
            case .Loading:
                print("loading")
                DispatchQueue.main.async {
                    self.coverIndicator.isHidden = false
                    self.collectionViewIndicator.isHidden = false
                }
                
            case .Failure:
                print("fail")
                DispatchQueue.main.async {
                    self.coverIndicator.isHidden = true
                    self.collectionViewIndicator.isHidden = true
                }
                
            default:
                print("default")
                
            }
            
        }.disposed(by: bag)
        
    }
    
    


}
    
