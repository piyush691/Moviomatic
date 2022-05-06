//
//  MyCollectionViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 02/04/22.
//

import UIKit
import Kingfisher
protocol CategoryRowDelegate: AnyObject {
    func cellTapped(_ info: Result)
}

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myLblTitle: UILabel!
    @IBOutlet var myImageView: UIImageView!
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModels: TableViewModel, of index: Int) {
        let model = viewModels.tableModel[index]
        myImageView.layer.cornerRadius = 15
        myImageView.clipsToBounds = true
        self.myLblTitle.sizeToFit()
        self.myLblTitle.text = model.title
        
        if let imagePath = model.posterPath  {
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(imagePath)")
            myImageView.kf.setImage(with: url)
        } else {
            myImageView.image = UIImage(named: "noimage")
        }
    }
    //    func downloadImageFrom(url: URL) {
    //        if let cachedImage = ViewController.imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
    //
    //            self.myImageView.image = cachedImage
    //        } else {
    //            URLSession.shared.dataTask(with: url) { data, response, error in
    //                guard let data = data, error == nil else { return }
    //                DispatchQueue.main.async {
    //                    let imageToCache = UIImage(data: data)
    //                    ViewController.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
    //                    self.myImageView.image = imageToCache
    //                }
    //            }.resume()
    //        }
    //    }
}
