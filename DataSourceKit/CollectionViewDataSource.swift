//
//  CollectionViewDataSource.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

public class CollectionViewDataSource<CellDeclaration>: NSObject, UICollectionViewDataSource {
    public var cellDeclarations = [] as [CellDeclaration]
    public typealias ConfigureSupplementaryView = (CollectionViewDataSource<CellDeclaration>, UICollectionView, String, IndexPath) -> UICollectionReusableView
    public var configureSupplementaryView: ConfigureSupplementaryView?

    private var registeredReuseIdentifiers = [] as [String]
    private let binderFromDeclaration: (CellDeclaration) -> CellBinder

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
        guard let configureSupplementaryView = self.configureSupplementaryView else {
            return UICollectionReusableView()
        }
        return configureSupplementaryView(self, collectionView, kind, indexPath)
    }

    public override func responds(to aSelector: Selector!) -> Bool {
        if aSelector == #selector(UICollectionViewDataSource.collectionView(_:viewForSupplementaryElementOfKind:at:)) {
            return configureSupplementaryView != nil
        }

        return super.responds(to: aSelector)
    }
}
