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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let baseUrl = "https://image.tmdb.org/t/p/w500\(movie!.backdrop_path)"
        print("base url \(baseUrl)")
        movieViewModel.scaleAndShowImage(url: URL(string: baseUrl)!, imageView: movieImage, size: CGSize(width: 750, height: 475))
        
        movieTitle.text = movie?.title
        movieDescription.text = movie?.overview
    }
    
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        
    }
    

}
