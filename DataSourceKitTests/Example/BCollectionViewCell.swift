//
//  BCollectionViewCell.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class BCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var idLabel: UILabel!
}

extension BCollectionViewCell: BindableCell {
    static func makeBinder(value: B) -> CellBinder {
        return CellBinder(
            cellType: BCollectionViewCell.self,
            registrationMethod: .nib(UINib(nibName: "BCollectionViewCell", bundle: Bundle(for: BCollectionViewCell.self))),
            reuseIdentifier: "BCollectionViewCell",
            configureCell: { cell in
                cell.idLabel.text = String(value.id)
        })
    }
}
