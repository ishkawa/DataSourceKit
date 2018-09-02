//
//  CellBinder.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import Foundation

public struct CellBinder {
    public let nib: UINib
    public let reuseIdentifier: String
    
    internal let configureCell: (Any) -> Void
    
    public init<Cell>(cellType: Cell.Type, nib: UINib, reuseIdentifier: String, configureCell: @escaping (Cell) -> Void) {
        self.nib = nib
        self.reuseIdentifier = reuseIdentifier
        self.configureCell = { cell in
            guard let cell = cell as? Cell else {
                fatalError("Could not cast UICollectionView cell to \(Cell.self)")
            }
            
            configureCell(cell)
        }
    }
}
