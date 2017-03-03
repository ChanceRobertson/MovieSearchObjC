//
//  MovieTableViewCell.swift
//  MovieSearchObjC
//
//  Created by Chance Robertson on 3/3/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: DMNMovie? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        guard let movie = movie else { return }
        self.titleLabel.text = movie.title
        self.ratingLabel.text = "Rating \(movie.rating)"
        self.descriptionLabel.text = movie.description
        
        DMNMovieController.fetchPoster(withURLString: movie.posterURLPath) { (poster) in
            DispatchQueue.main.async {
                self.posterImageView.image = poster
            }
        }
    }
}
