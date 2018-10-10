//
//  ATableViewCell.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class ATableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
}

extension ATableViewCell: BindableCell {
    static func makeBinder(value: A) -> CellBinder {
        return CellBinder(
            cellType: ATableViewCell.self,
            registrationMethod: .nib(UINib(nibName: "ATableViewCell", bundle: Bundle(for: ATableViewCell.self))),
            reuseIdentifier: "ATableViewCell",
            configureCell: { cell in
                cell.idLabel.text = String(value.id)
        })
    }
}
