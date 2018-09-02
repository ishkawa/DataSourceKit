//
//  TestCellA.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

struct A {
    let id: Int64
}

final class TestCellA: UICollectionViewCell {
    @IBOutlet weak var idLabel: UILabel!
}

extension TestCellA: BindableCell {
    static func makeBinder(value: A) -> CellBinder {
        return CellBinder(
            cellType: TestCellA.self,
            nib: UINib(nibName: "TestCellA", bundle: Bundle(for: TestCellA.self)),
            reuseIdentifier: "TestCellA",
            configureCell: { cell in
                cell.idLabel.text = String(value.id)
            })
    }
}
