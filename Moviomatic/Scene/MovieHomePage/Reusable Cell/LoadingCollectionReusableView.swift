//
//  LoadingCollectionReusableView.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 25/04/22.
//

import UIKit

class LoadingCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    static func nib() -> UINib{
        return UINib(nibName: "LoadingCollectionReusableView", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
