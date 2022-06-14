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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
