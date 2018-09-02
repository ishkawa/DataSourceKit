//
//  TestCellB.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

struct B {
    let id: Int64
}

final class TestCellB: UICollectionViewCell {
    @IBOutlet weak var idLabel: UILabel!
}

extension TestCellB: BindableCell {
    static func makeBinder(value: B) -> CellBinder {
        return CellBinder(
            cellType: TestCellB.self,
            nib: UINib(nibName: "TestCellB", bundle: Bundle(for: TestCellB.self)),
            reuseIdentifier: "TestCellB",
            configureCell: { cell in
                cell.idLabel.text = String(value.id)
        })
    }
}
