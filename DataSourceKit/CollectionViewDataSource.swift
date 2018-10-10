//
//  CollectionViewDataSource.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

open class CollectionViewDataSource<CellDeclaration>: NSObject, UICollectionViewDataSource {
    open var cellDeclarations = [] as [CellDeclaration]
    
    private var registeredReuseIdentifiers = [] as [String]
    private let binderFromDeclaration: (CellDeclaration) -> CellBinder
    
    public init(binderFromDeclaration: @escaping (CellDeclaration) -> CellBinder) {
        self.binderFromDeclaration = binderFromDeclaration
        super.init()
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDeclarations.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellBinder = binderFromDeclaration(cellDeclarations[indexPath.item])
        if !registeredReuseIdentifiers.contains(cellBinder.reuseIdentifier) {
            switch cellBinder.registrationMethod {
            case let .nib(nib):
                collectionView.register(nib, forCellWithReuseIdentifier: cellBinder.reuseIdentifier)
            case let .class(cellClass):
                collectionView.register(cellClass, forCellWithReuseIdentifier: cellBinder.reuseIdentifier)
            case .none:
                break
            }
            registeredReuseIdentifiers.append(cellBinder.reuseIdentifier)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBinder.reuseIdentifier, for: indexPath)
        cellBinder.configureCell(cell)
        
        return cell
    }
}

extension CollectionViewDataSource where CellDeclaration == CellBinder {
    // Add meaningless parameter to avoid error `Members of constrained extensions
    // cannot be declared @objc`, which is caused by collision to init() of NSObject.
    public convenience init(binderFromBinder: @escaping (CellBinder) -> CellBinder = { $0 }) {
        self.init(binderFromDeclaration: binderFromBinder)
    }
}
