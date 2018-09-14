//
//  SectionHeaderCell.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class SectionHeaderCell: CollectionViewFullWidthCell {
    @IBOutlet private weak var titleLabel: UILabel!
}

extension SectionHeaderCell: BindableCell {
    static func makeBinder(value title: String) -> CellBinder {
        return CellBinder(
            cellType: SectionHeaderCell.self,
            registrationMethod: .nib(UINib(nibName: "SectionHeaderCell", bundle: nil)),
            reuseIdentifier: "SectionHeader",
            configureCell: { cell in
                cell.titleLabel.text = title
            })
    }
}
