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
    var isSuccess:Bool = false
    var movieForCollection:Movie?
    var movieForCover:Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        coverImageView.addGestureRecognizer(tapGR)
        coverImageView.isUserInteractionEnabled = true
        
        
        
        movieViewModel.getMovies().subscribe { Resource in
            
            switch Resource.element?.status{
                
            case .Success:
                print("success")
                self.isSuccess = true
                
                self.movieArray = Resource.element!.data!.results
                
                DispatchQueue.main.async {
                    let baseUrl = "https://image.tmdb.org/t/p/w500"
                    let randomInt = Int.random(in: 0..<self.movieArray.count)
                    self.movieForCover = self.movieArray[randomInt]
                    
                    self.movieViewModel.scaleAndShowImage(url: URL(string: "\(baseUrl)\(self.movieArray[randomInt].backdrop_path)")!, imageView: self.coverImageView, size: CGSize(width: 500, height: 350))
                    
                    self.coverIndicator.isHidden = true
                    self.collectionViewIndicator.isHidden = true
                    self.coverImageText.text = self.movieArray[randomInt].title
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
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            performSegue(withIdentifier: "goToDetail", sender: self)
        }
    }
    
}



extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        
        for _ in movieArray {
            self.movieViewModel.scaleAndShowImage(url: URL(string: "\(baseUrl)\(self.movieArray[indexPath.row].poster_path)")!, imageView: cell.movieImageView, size: CGSize(width: 150, height: 225))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieForCollection = movieArray[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "goToDetail":
            let detailVC = segue.destination as? DetailViewController
            if movieForCollection != nil {
                detailVC?.movie = movieForCollection
                movieForCollection = nil
            }
            else{
                detailVC?.movie = movieForCover
                
            }
            
            
        default:
            print("default")
            
        }
    }
    
}






