//
//  DetailViewController.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 9.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie:Movie?
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    let movieViewModel = MovieViewModel()
    let favoriteViewModel = FavoritesViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchResultsController = try? CoreDataManager.createFetchResultsController()
    var favoritesMovieArray:[MovieEntity]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let baseUrl = "https://image.tmdb.org/t/p/w500\(movie!.backdrop_path)"
        print("base url \(baseUrl)")
        movieViewModel.scaleAndShowImage(url: URL(string: baseUrl)!, imageView: movieImage, size: CGSize(width: 750, height: 475))
        
        movieTitle.text = movie?.title
        movieDescription.text = movie?.overview
        try? fetchResultsController?.performFetch()
        favoritesMovieArray = fetchResultsController?.fetchedObjects
    }
    
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        var alreadySaved:Bool = false
    
        for favoriteMovie in favoritesMovieArray! {
            if favoriteMovie.title == movie?.title{
                alreadySaved = true
            }
        }
        
        if alreadySaved == false {
            favoriteViewModel.saveToDatabase(favoriteMovie: movie!)
            showAlert(title: "Successfully Added!")
        }else{
            showAlert(title: "Already Added!")
        }
        
    }
    
    func showAlert(title:String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alert, animated: true)
        
    }
    

}
