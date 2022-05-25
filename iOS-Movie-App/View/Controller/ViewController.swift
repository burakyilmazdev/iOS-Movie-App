//
//  ViewController.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 25.05.2022.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    let movieArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
        
        return cell
    }
    
    
    
    
    
}

