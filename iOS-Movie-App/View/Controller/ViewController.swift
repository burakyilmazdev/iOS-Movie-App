//
//  ViewController.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 25.05.2022.
//

import UIKit
import RxSwift
import Kingfisher


class ViewController: UIViewController {
    

    @IBOutlet weak var collectionViewIndicator: UIActivityIndicatorView!
    @IBOutlet weak var coverIndicator: UIActivityIndicatorView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var coverImageText: UILabel!
    
    let movieViewModel = MovieViewModel()
    private var bag = DisposeBag()
    var movieArray = [Movie]()
    var observableMovieArray = PublishSubject<[Movie]>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        
        
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
                
                self.observableMovieArray.onNext(self.movieArray)
                DispatchQueue.main.async {
                    
                    self.movieViewModel.scaleAndShowImage(url: URL(string: "https://image.tmdb.org/t/p/w500/AbgEQO2mneCSOc8CSnOMa8pBS8I.jpg")!, imageView: self.coverImageView)
                    
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
                    let alert = UIAlertController(title: "Error", message: "Please try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                    
                }
                
            default:
                print("default")
                
            }
            
        }.disposed(by: bag)
               
        
    }

}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        print("collection \(movieArray[indexPath.row].backdrop_path)")
        let image = UIImage(named: "sr_200")
        let size = CGSize(width: 150, height: 225)
        let scaledImage =  UIImage.scaleImage(img: image!, size: size)
        cell.movieImageView.image = scaledImage
        
        return cell
    }
    
}



    
