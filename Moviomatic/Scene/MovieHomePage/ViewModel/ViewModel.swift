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
//        let dispatchGroup = DispatchGroup()
        
//        dispatchGroup.enter()
        let url1 = "https://api.themoviedb.org/3/movie/now_playing?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url1) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Now Playing", model: list.results))
//            dispatchGroup.leave()
        }
//        dispatchGroup.enter()
        let url2 = "https://api.themoviedb.org/3/movie/popular?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url2) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Popular", model: list.results))
//            dispatchGroup.leave()
            
        }
//        dispatchGroup.enter()
        let url3 = "https://api.themoviedb.org/3/movie/top_rated?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url3) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Top Rated", model: list.results))
//            dispatchGroup.leave()
            
        }
//        dispatchGroup.enter()
        let url4 = "https://api.themoviedb.org/3/movie/upcoming?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<MovieModel>.fetchData(withURL: url4) {[weak self] data in
            guard let list = data, let self = self else { return }
            self.modelData.append(TitleModel(title: "Upcoming", model: list.results))
//            dispatchGroup.leave()
            completion()
        }
    }
    
    //    var nowPlayingMovieList: [Result]?
    //    func fetchMovieList(_ completion: @escaping (() -> Void)) {
    //        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=a1a1778171f931795dc131163e0c7399"
    //
    //        Parser<MovieModel>.fetchData(withURL: url) { [self] data in
    //            if let list = data {
    //                self.nowPlayingMovieList = (list.results)
    //            }
    //            completion()
    //        }
    //    }
    //
    //    var popularMovieList: [Result]?
    //    func popularFetchMovieList(_ completion: @escaping (() -> Void)) {
    //        let url = "https://api.themoviedb.org/3/movie/popular?api_key=a1a1778171f931795dc131163e0c7399"
    //
    //        Parser<MovieModel>.fetchData(withURL: url) { [self] data in
    //            if let list = data {
    //                self.popularMovieList = (list.results)
    //            }
    //            completion()
    //        }
    //    }
    //
    //    var topRatedMovieList: [Result]?
    //    func TopRatedFetchMovieList(_ completion: @escaping (() -> Void)) {
    //        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=a1a1778171f931795dc131163e0c7399"
    //
    //        Parser<MovieModel>.fetchData(withURL: url) { [self] data in
    //            if let list = data {
    //                self.topRatedMovieList = (list.results)
    //            }
    //            completion()
    //        }
    //    }
    //
    //    var upcomingMovieList: [Result]?
    //    func UpcomingFetchMovieList(_ completion: @escaping (() -> Void)) {
    //        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=a1a1778171f931795dc131163e0c7399"
    //
    //        Parser<MovieModel>.fetchData(withURL: url) { [self] data in
    //            if let list = data {
    //                self.upcomingMovieList = (list.results)
    //            }
    //            completion()
    //        }
    //    }
}

//extension NowPlayingViewModel {
//    func numberofSection() -> Int {
//        return self.nowPlayingMovieList?.count ?? 0
//    }
//
//    func numberOfRows(inSection section: Int) -> Int {
//        return self.nowPlayingMovieList?.count ?? 0
//    }
//
//    func getTitle(forSection section: Int) -> String {
//        return self.nowPlayingMovieList?[section].title ?? ""
//    }
//
//    func getData(atIndexPath indexpath: IndexPath) -> Result? {
//        return self.nowPlayingMovieList?[indexpath.row]
//    }
//}



// Use in View

//    func loadData() {
//
//        viewModel.fetchMovieList { [weak self] in
//            guard let self = self else {
//                return
//            }
//            self.viewModel.modelData.append(TitleModel(title: "Now Playing", model: self.viewModel.nowPlayingMovieList!))
//        }
//        viewModel.popularFetchMovieList {  [weak self] in
//            guard let self = self else {
//                return
//            }
//            self.viewModel.modelData.append(TitleModel(title: "Popular", model: self.viewModel.popularMovieList!))
//        }
//        viewModel.TopRatedFetchMovieList {  [weak self] in
//            guard let self = self else {
//                return
//            }
//            self.viewModel.modelData.append(TitleModel(title: "Top Rated", model: self.viewModel.topRatedMovieList!))
//        }
//        viewModel.UpcomingFetchMovieList {  [weak self] in
//            guard let self = self else {
//                return
//            }
//            self.viewModel.modelData.append(TitleModel(title: "Upcoming", model: self.viewModel.upcomingMovieList!))
//            DispatchQueue.main.sync {
//                self.tableView.reloadData()
//            }
//        }
//    }
