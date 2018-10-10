//
//  CollectionViewDataSourceTests.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import Foundation
import XCTest
import DataSourceKit

class CollectionViewDataSourceTests: XCTestCase {
    enum CellDeclaration {
        case a(A)
        case b(B)
        case c(C)
    }
    
    struct Data: CellsDeclarator {
        var a: [A]
        var b: [B]
        var c: [C]

        func declareCells(_ cell: (CellDeclaration) -> Void) {
            for a in a {
                cell(.a(a))
            }
            for b in b {
                cell(.b(b))
            }
            for c in c {
                cell(.c(c))
            }
        }
    }

    var dataSource: CollectionViewDataSource<CellDeclaration>!
    var collectionView: TestCollectionView!

    override func setUp() {
        super.setUp()
        
        dataSource = CollectionViewDataSource<CellDeclaration> { declaration in
            switch declaration {
            case .a(let a):
                return ACollectionViewCell.makeBinder(value: a)
            case .b(let b):
                return BCollectionViewCell.makeBinder(value: b)
            case .c(let c):
                return CCollectionViewCell.makeBinder(value: c)
            }
        }
        
        collectionView = TestCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
    }

    func test() {
        let data = Data(a: [A(id: 1), A(id: 2)], b: [B(id: 1)], c: [C(id: 1)])
        dataSource.cellDeclarations = data.cellDeclarations
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 4)
        XCTAssertEqual(collectionView.nibRegistrations.map({ $0.reuseIdentifier }), ["ACollectionViewCell", "BCollectionViewCell"])
        XCTAssertEqual(collectionView.classRegistrations.map({ $0.reuseIdentifier }), ["CCollectionViewCell"])
        
        let verifiers: [(UICollectionViewCell?) -> Void] = [
            { cell in
                let cell = cell as? ACollectionViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "1")
            },
            { cell in
                let cell = cell as? ACollectionViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "2")
            },
            { cell in
                let cell = cell as? BCollectionViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "1")
            },
            { cell in
                let cell = cell as? CCollectionViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "1")
            }
        ]
        
        for (index, verifier) in verifiers.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            let cell = collectionView.cellForItem(at: indexPath)
            verifier(cell)
        }
    }
}
