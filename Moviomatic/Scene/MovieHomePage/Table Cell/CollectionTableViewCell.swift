//
//  CollectionTableViewCell.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 02/04/22.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    lazy var tableViewModel = TableViewModel()
    var index: Int?
    @IBOutlet var collectionView: UICollectionView!
    weak var delegate:CategoryRowDelegate?
    static func nib() ->UINib {
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: "MyCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModels: TableViewModel) {
        self.tableViewModel = viewModels
        self.collectionView.reloadData()
    }
}
extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableViewModel.tableModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.configure(with: tableViewModel, of: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let i = tableViewModel.index, (i == 0 || i == 3) {
            return CGSize(width: 240, height: 340)
        }
        return CGSize(width: 160, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(self.tableViewModel.tableModel[indexPath.row])
        }
    }
}
