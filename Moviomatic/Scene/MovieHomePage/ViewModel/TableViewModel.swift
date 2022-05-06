//
//  TableViewModel.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 05/04/22.
//

import Foundation

struct TableViewModel {
    var tableModel = [Result]()
    var index: Int?
    
   mutating func setParam(_ viewModel: ViewModel, _ index: Int) {
        self.tableModel = viewModel.modelData[index].model
        self.index = index
    }
}
