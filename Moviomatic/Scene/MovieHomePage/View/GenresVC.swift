//
//  GenresVC.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 18/04/22.
//

import UIKit

class GenresVC: UIViewController {
    
    @IBOutlet var genresCollectionView: UICollectionView!
    lazy var genresViewModel = GenresViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .black
        setupCollectionViews()
        genresViewModel.loadContent {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.genresCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectedGenreSegue" {
            if let vc = segue.destination as? SelectedGenreVC {
                vc.genreId = sender as? Int
            }
        }
    }
    
    func setupCollectionViews() {
        genresCollectionView.dataSource = self
        genresCollectionView.delegate = self
        genresCollectionView.register(GenresCollectionViewCell.nib(), forCellWithReuseIdentifier: "GenresCollectionViewCell")
    }
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat.random(in: 0...1)
        let greenValue = CGFloat.random(in: 0...1)
        let blueValue = CGFloat.random(in: 0...1)
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 0.6)
        return randomColor
    }
}

extension GenresVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresViewModel.genresModelData?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genresCollectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as! GenresCollectionViewCell
        cell.lblText.text = self.genresViewModel.genresModelData.genres![indexPath.row].name! + "    "
        cell.lblText.textColor = .white
        let color: UIColor = generateRandomColor()
        cell.lblText.backgroundColor = color
        cell.lblText.layer.borderColor = color.cgColor
        cell.lblText.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = genresViewModel.genresModelData.genres![indexPath.row].id
        self.performSegue(withIdentifier: "SelectedGenreSegue", sender: id)
    }
}
