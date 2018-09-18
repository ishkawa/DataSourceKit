//
//  CollectionViewDataSource.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

open class CollectionViewDataSource<CellDeclaration>: NSObject, UICollectionViewDataSource {
    public var cellDeclarations = [] as [CellDeclaration]
    
    private var registeredReuseIdentifiers = [] as [String]
    private let binderFromDeclaration: (CellDeclaration) -> CellBinder
    public typealias ConfigureSupplementaryView = (CollectionViewDataSource<CellDeclaration>, UICollectionView, String, IndexPath) -> UICollectionReusableView
    open var configureSupplementaryView: ConfigureSupplementaryView?

    public init(binderFromDeclaration: @escaping (CellDeclaration) -> CellBinder) {
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


    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return configureSupplementaryView!(self, collectionView, kind, indexPath)
    }

    open override func responds(to aSelector: Selector!) -> Bool {
        if aSelector == #selector(UICollectionViewDataSource.collectionView(_:viewForSupplementaryElementOfKind:at:)) {
            return configureSupplementaryView != nil
        } else {
            return super.responds(to: aSelector)
        }
    }
}
