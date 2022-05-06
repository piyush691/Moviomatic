//
//  VideoCollectionViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 21/04/22.
//

import UIKit
import Kingfisher
class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myImageView: UIImageView!
    static func nib() -> UINib {
        return UINib(nibName: "VideoCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModels: [Video], of index: Int) {
        let model = viewModels[index]
        myImageView.image = nil
        myImageView.layer.cornerRadius = 15
        myImageView.clipsToBounds = true
        myImageView.image = UIImage(named: "noimage")
        if let youtubeId = model.key  {
            let url = URL(string:"https://img.youtube.com/vi/\(youtubeId)/maxresdefault.jpg")!
            myImageView.kf.setImage(with: url)
        } else {
            myImageView.image = UIImage(named: "noimage")
        }
    }
}
