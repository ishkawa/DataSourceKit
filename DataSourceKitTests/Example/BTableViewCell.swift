//
//  BTableViewCell.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class BTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
}

extension BTableViewCell: BindableCell {
    static func makeBinder(value: B) -> CellBinder {
        return CellBinder(
            cellType: BTableViewCell.self,
            registrationMethod: .nib(UINib(nibName: "BTableViewCell", bundle: Bundle(for: BTableViewCell.self))),
            reuseIdentifier: "BTableViewCell",
            configureCell: { cell in
                cell.idLabel.text = String(value.id)
        })
    }
}
