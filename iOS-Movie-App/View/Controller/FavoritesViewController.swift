//
//  FavoritesViewController.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 10.06.2022.
//

import UIKit
import RxSwift
import Kingfisher
import CoreData
import SwiftUI

class FavoritesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    private var bag = DisposeBag()
    var fetchedResultsController: NSFetchedResultsController<MovieEntity>!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let favoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.backgroundColor = UIColor.black
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        searchBar.delegate = self
        

       let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
                
        setupFetchResultsController()
        hideKeyboardWhenTappedAround()
        
    }
    
    func hideKeyboardWhenTappedAround() {
            let tapGesture = UITapGestureRecognizer(target: self,
                             action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        }

        @objc func hideKeyboard() {
            view.endEditing(true)
        }
    
    
    
    func setupFetchResultsController(filter:String? = nil){
        fetchedResultsController = CoreDataManager.createFetchResultsController(filter: filter)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()

    }

}


extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("section : \(section)")
        let movies = fetchedResultsController.sections![section]
        return movies.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(225.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let moviePoster = fetchedResultsController.object(at: indexPath).poster_path
        let moviePosterURLforKF = URL(string: "\(baseUrl)\(moviePoster!)")
        
        favoritesViewModel.scaleAndShowImage(url: moviePosterURLforKF!, imageView: cell.favoriteImageView, size: CGSize(width: 150, height: 225))
        cell.favoriteMovieTitle.text = fetchedResultsController.object(at: indexPath).title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            self.favoritesViewModel.delete(movieToRemove: self.fetchedResultsController.object(at: indexPath))
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

extension FavoritesViewController:NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            favoritesTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            favoritesTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            favoritesTableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            favoritesTableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            favoritesTableView.reloadData()
        }
    }
    
}

extension FavoritesViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count>=1 {
            print("wiht filter")
            setupFetchResultsController(filter: searchText)
            favoritesTableView.reloadData()
        }
        else{
            print("wihtout filter")
            setupFetchResultsController()
            favoritesTableView.reloadData()
            
        }
       
    }
    
    
}


