//
//  GenresViewModel.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 18/04/22.
//

import UIKit
class GenresViewModel {
    var genresModelData: GenresModel!
    func loadContent(_ completion: @escaping (() -> Void)) {
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<GenresModel>.fetchData(withURL: url) { [weak self] data in
            guard let list = data, let self = self else { return }
            self.genresModelData = list
            completion()
        }
    }
}
