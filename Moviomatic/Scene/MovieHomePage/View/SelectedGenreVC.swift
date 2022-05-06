//
//  SelectedGenreVC.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 18/04/22.
//

import UIKit
class SelectedGenreVC: UIViewController {
    
    @IBOutlet weak var generalCollectionView: UICollectionView!
    var genreId: Int?
    var query: String?
    var isLoading = false
    var loadingView: LoadingCollectionReusableView?
    lazy var generalViewModel = GeneralViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .yellow
        view.backgroundColor = .black
        setupCollectionView()
        
        if let genreId = genreId {
            generalViewModel.loadContent(genreId) {[weak self] in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    self.generalCollectionView.reloadData()
                }
            }
        } else if let query = query {
            generalViewModel.searchContent(query) {[weak self] in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    sleep(1)
                    self.generalCollectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailsSegue" {
            if let vc = segue.destination as? MovieContentVC {
                vc.info = sender as? Result
            }
        }
    }
    
    func setupCollectionView() {
        generalCollectionView.dataSource = self
        generalCollectionView.delegate = self
        //        generalCollectionView.isPagingEnabled = true
        generalCollectionView.clipsToBounds = true
        generalCollectionView.register(GeneralCollectionViewCell.nib(), forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        generalCollectionView.register(LoadingCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingCollectionReusableView")
        generalCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension SelectedGenreVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generalViewModel.selectedGenreModelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as! GeneralCollectionViewCell
        cell.configure(with: generalViewModel.selectedGenreModelData, of: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if generalViewModel.currentPage < generalViewModel.totalPage && indexPath.row == generalViewModel.selectedGenreModelData.count - 1 && !self.isLoading {
            
            self.isLoading = true
            generalViewModel.currentPage = generalViewModel.currentPage + 1
            if self.genreId != nil {
                DispatchQueue.global().async {[weak self] in
                    sleep(1)
                    self!.generalViewModel.loadContent(self!.genreId!) {[weak self] in
                        guard let self = self else { return }
                        DispatchQueue.main.async {
                            let indexSet = IndexSet(integer: 0)
                            self.generalCollectionView.reloadSections(indexSet)
                            self.isLoading = false
                        }
                    }
                }
            }
            else if self.query != nil {
                DispatchQueue.global().async {
                    sleep(1)
                    self.generalViewModel.searchContent(self.query!) {[weak self] in
                        guard let self = self else { return }
                        DispatchQueue.main.async {
                            let indexSet = IndexSet(integer: 0)
                            self.generalCollectionView.reloadSections(indexSet)
                            self.isLoading = false
                        }
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MovieDetailsSegue", sender: generalViewModel.selectedGenreModelData[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingCollectionReusableView", for: indexPath) as! LoadingCollectionReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loadingIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loadingIndicator.stopAnimating()
        }
    }
}
