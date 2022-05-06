//
//  GeneralViewModel.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 18/04/22.
//

import Foundation
class GeneralViewModel {
    var selectedGenreModelData = [Result]()
    var totalPage = 1
    var currentPage = 1
    func loadContent(_ id: Int, _ completion: @escaping (() -> Void)) {
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=a1a1778171f931795dc131163e0c7399&page=\(currentPage)&with_genres=\(id)"
        Parser<MovieModel>.fetchData(withURL: url) { [weak self] data in
            
            guard let self = self else {
                return
            }
            if let list = data {
                self.totalPage = list.totalPages!
                self.currentPage = list.page!
                self.selectedGenreModelData += list.results
            }
            completion()
        }
    }
    
    func searchContent(_ query: String, _ completion: @escaping (() -> Void)) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=a1a1778171f931795dc131163e0c7399&page=\(currentPage)&query=\(query)"
        Parser<MovieModel>.fetchData(withURL: url) { [weak self] data in
            
            guard let self = self else {
                return
            }
            if let list = data {
                self.totalPage = list.totalPages!
                self.currentPage = list.page!
                self.selectedGenreModelData += list.results
            }
            completion()
        }
    }
}
