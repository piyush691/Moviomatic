//
//  RecentTableViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 24/04/22.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    
    @IBOutlet var lblText: UILabel!
    static func nib() -> UINib {
        return UINib(nibName: "RecentTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
