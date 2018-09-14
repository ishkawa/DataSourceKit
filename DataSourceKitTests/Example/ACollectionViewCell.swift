//
//  ACollectionViewCell.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class ACollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var idLabel: UILabel!
}

extension ACollectionViewCell: BindableCell {
    static func makeBinder(value: A) -> CellBinder {
        return CellBinder(
            cellType: ACollectionViewCell.self,
            registrationMethod: .nib(UINib(nibName: "ACollectionViewCell", bundle: Bundle(for: ACollectionViewCell.self))),
            reuseIdentifier: "ACollectionViewCell",
            configureCell: { cell in
                cell.idLabel.text = String(value.id)
            })
    }
}
