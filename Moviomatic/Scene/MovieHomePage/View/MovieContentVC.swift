//
//  MovieContentVC.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 06/04/22.
//

import UIKit

class MovieContentVC: UIViewController {
    var info: Result?
    @IBOutlet var contentImg: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblOverview: UILabel!
    @IBOutlet var lblTagline: UILabel!
    @IBOutlet var lblOriginalTitle: UILabel!
    @IBOutlet var lblReleaseDate: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblBudget: UILabel!
    @IBOutlet var lblRevenue: UILabel!
    @IBOutlet var lblRuntime: UILabel!
    @IBOutlet var genresCollection: UICollectionView!
    @IBOutlet var castCollection: UICollectionView!
    @IBOutlet var videoCollection: UICollectionView!
    lazy var contentViewModel = ContentViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .yellow
        view.backgroundColor = .black
        setupCollectionViews()
        contentViewModel.loadContent(id: (info?.id)!) { [weak self] in
            guard let self = self, let contentData = self.contentViewModel.contentModelData else { return }
            
            guard let imagePath = contentData.backdropPath else {
                return
            }
            self.lblTitle.text = contentData.title
            self.lblOverview.text = contentData.overview
            self.lblTagline.text = contentData.tagline
            self.lblOriginalTitle.text = "Original Title:  \(String(describing: contentData.originalTitle!))"
            self.lblReleaseDate.text = "Release Date:  \(String(describing: contentData.releaseDate!))"
            self.lblStatus.text = "Status:\t\t\t\(String(describing: contentData.status!))"
            self.lblBudget.text = "Budget:\t\t$\(String(describing: contentData.budget!))"
            self.lblRevenue.text = "Revenue:\t\t$\(String(describing: contentData.releaseDate!))"
            self.lblRuntime.text = "Runtime:\t\t\(String(describing: contentData.runtime!)) min"
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")
            DispatchQueue.main.async {
                if let imageData = try? Data(contentsOf: url!) {
                    if let loadedImage = UIImage(data: imageData) {
                        self.contentImg.image = loadedImage
                    }
                }
                self.genresCollection.reloadData()
                self.castCollection.reloadData()
                self.videoCollection.reloadData()
            }
        }
    }
    
    func setupCollectionViews() {
        genresCollection.dataSource = self
        genresCollection.delegate = self
        castCollection.dataSource = self
        castCollection.delegate = self
        videoCollection.dataSource = self
        videoCollection.delegate = self
        genresCollection.tag = 1000
        castCollection.tag = 2000
        videoCollection.tag = 3000
        genresCollection.register(GenresCollectionViewCell.nib(), forCellWithReuseIdentifier: "GenresCollectionViewCell")
        castCollection.register(CastCollectionViewCell.nib(), forCellWithReuseIdentifier: "CastCollectionViewCell")
        videoCollection.register(VideoCollectionViewCell.nib(), forCellWithReuseIdentifier: "VideoCollectionViewCell")
    }
}

extension MovieContentVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1000 {
            return self.contentViewModel.contentModelData?.genres!.count ?? 0
        } else if collectionView.tag == 2000 {
            return self.contentViewModel.castModelData?.cast!.count ?? 0
        } else if collectionView.tag == 3000 {
            return self.contentViewModel.videoModel?.results?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1000 {
            let cell = genresCollection.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as! GenresCollectionViewCell
            cell.lblText.text = (self.contentViewModel.contentModelData?.genres![indexPath.row].name!)! + "  "
            return cell
        }
        else if collectionView.tag == 2000 {
            let cell = castCollection.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
            cell.configure(with: self.contentViewModel.castModelData!, of: indexPath.row)
            return cell
        }
        else {
            let cell = videoCollection.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            cell.configure(with: (self.contentViewModel.videoModel?.results)!, of: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 3000 {
            guard let youtubeId = contentViewModel.videoModel?.results![indexPath.row].key else { return }
            guard let url = URL(string:"https://www.youtube.com/watch?v=\(youtubeId)") else { return }
            UIApplication.shared.open(url)
        }
    }
}

