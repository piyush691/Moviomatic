//
//  ContentViewModel.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 11/04/22.
//
import UIKit
class ContentViewModel {
    var contentModelData: ContentModel?
    var castModelData: CastModel?
    var videoModel: VideoModel?
    
    func loadContent(id: Int, _ completion: @escaping (() -> Void)) {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        let url1 = "https://api.themoviedb.org/3/movie/\(id)?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<ContentModel>.fetchData(withURL: url1) { [weak self] data in
            guard let list = data, let self = self else { return }
            self.contentModelData = list
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let url2 = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<CastModel>.fetchData(withURL: url2) { [weak self] data in
            guard let list = data, let self = self else { return }
            self.castModelData = list
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let url3 = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a1a1778171f931795dc131163e0c7399"
        Parser<VideoModel>.fetchData(withURL: url3) { [weak self] data in
            guard let list = data, let self = self else { return }
            self.videoModel = list
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}

