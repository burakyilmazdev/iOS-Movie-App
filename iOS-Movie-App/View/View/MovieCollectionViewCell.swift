//
//  MovieCollectionViewCell.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 20.06.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieImageView.layer.borderWidth = 1
        movieImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.5)
    }

}
