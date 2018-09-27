//
//  CollectionViewDataSource.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

public class CollectionViewDataSource<CellDeclaration>: NSObject, UICollectionViewDataSource {
    public typealias Configurator = (CellDeclaration) -> CellBinder
    public var cellDeclarations = [] as [CellDeclaration]
    
    private var registeredReuseIdentifiers = [] as [String]
    private let binderFromDeclaration: Configurator
    
    public init(binderFromDeclaration: @escaping Configurator) {
        self.binderFromDeclaration = binderFromDeclaration
        super.init()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDeclarations.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
