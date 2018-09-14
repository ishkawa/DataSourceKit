//
//  CCollectionViewCell.swift
//  DataSourceKitTests
//
//  Created by zhzh liu on 2018/9/10.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

class CCollectionViewCell: UICollectionViewCell {
    var idLabel = UILabel(frame: .zero)
}

extension CCollectionViewCell: BindableCell {
    static func makeBinder(value: C) -> CellBinder {
        return CellBinder(
            cellType: CCollectionViewCell.self,
            registrationMethod: .class(CCollectionViewCell.self),
            reuseIdentifier: "CCollectionViewCell",
            configureCell: { (cell) in
                cell.idLabel.text = "\(value.id)"
        })
    }
}
