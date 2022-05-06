//
//  Parser.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 03/04/22.
//

import Foundation

struct Parser<T: Codable> {
    static func fetchData(withURL urlString: String, _ completion: @escaping ((T?) -> Void)) {
        let urlsession = URLSession.shared
        guard let url = URL(string: urlString) else { return }
        let task = urlsession.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error in network session \(error!)")
                return
            }
            guard let data = data else {
                return
            }
            let model = try? JSONDecoder().decode(T.self, from: data)
            completion(model)
        }
        task.resume()
    }
}
