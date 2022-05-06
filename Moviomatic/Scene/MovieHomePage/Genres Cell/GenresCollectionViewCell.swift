//
//  GenresCollectionViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 11/04/22.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    @IBOutlet var lblText: UILabel!
    static func nib() ->UINib {
        return UINib(nibName: "GenresCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblText.layer.masksToBounds = true
        lblText.layer.cornerRadius = 10
        // Initialization code
    }
}
