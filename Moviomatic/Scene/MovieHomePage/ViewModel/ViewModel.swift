//
//  ViewModel.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 03/04/22.
//

import Foundation

class ViewModel {
    
    var modelData = [TitleModel]()
    
    func loadData(_ completion: @escaping (() -> Void)){
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let url1 = "https://api.themoviedb.org/3/movie/now_playing?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url1) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Now Playing", model: list.results))
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let url2 = "https://api.themoviedb.org/3/movie/popular?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url2) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Popular", model: list.results))
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let url3 = "https://api.themoviedb.org/3/movie/top_rated?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url3) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Top Rated", model: list.results))
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let url4 = "https://api.themoviedb.org/3/movie/upcoming?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url4) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Upcoming", model: list.results))
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}
