//
//  GeneralCollectionViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 18/04/22.
//

import UIKit
import Kingfisher
class GeneralCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myLblTitle: UILabel!
    @IBOutlet var myImageView: UIImageView!
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    static func nib() -> UINib {
        return UINib(nibName: "GeneralCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModels: [Result], of index: Int) {
        let model = viewModels[index]
        myImageView.layer.cornerRadius = 15
        myImageView.clipsToBounds = true
        myLblTitle.sizeToFit()
        myLblTitle.text = model.title
        if let imagePath = model.posterPath  {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(imagePath)")
            myImageView.kf.setImage(with: url)
            
        } else {
            myImageView.image = UIImage(named: "noimage")
        }
        
    }
}
