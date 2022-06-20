//
//  FavoriteTableViewCell.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 13.06.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteImageView.layer.borderWidth = 1
        favoriteImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
