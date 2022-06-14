//
//  FavoritesViewController.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 10.06.2022.
//

import UIKit
import RxSwift
import Kingfisher

class FavoritesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    var favoritesMovies = [MovieEntity]()
    private var bag = DisposeBag()
    
    
    let favoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.backgroundColor = UIColor.black
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
       let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
        
        
    
        
        
        favoritesViewModel.fetchFavoritesMovies().subscribe { MovieEntityList in
            self.favoritesMovies = MovieEntityList
        }.disposed(by: bag)
    }

}


extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        
        cell.favoriteMovieTitle.text = favoritesMovies[indexPath.row].title
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let moviePoster = favoritesMovies[indexPath.row].poster_path
        let moviePosterURLforKF = URL(string: "\(baseUrl)\(moviePoster!)")
        
        favoritesViewModel.scaleAndShowImage(url: moviePosterURLforKF!, imageView: cell.favoriteImageView, size: CGSize(width: 150, height: 225))
        
        return cell
    }
    
    
    
}


