//
//  CastCollectionViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 12/04/22.
//

import UIKit
import Kingfisher
class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var myImageView: UIImageView!
    static func nib() -> UINib {
        return UINib(nibName: "CastCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModels: CastModel, of index: Int) {
        let model = viewModels.cast![index]
        myImageView.layer.cornerRadius = 15
        myImageView.clipsToBounds = true
        myImageView.image = nil
        self.lblTitle.sizeToFit()
        self.lblTitle.text = model.name
        if let imagePath = model.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")
            myImageView.kf.setImage(with: url)
        } else {
            myImageView.image = UIImage(named: "noimage")
        }
    }
}
