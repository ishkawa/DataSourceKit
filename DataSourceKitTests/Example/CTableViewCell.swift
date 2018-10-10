//
//  CTableViewCell.swift
//  DataSourceKitTests
//
//  Created by zhzh liu on 2018/9/10.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

class CTableViewCell: UITableViewCell {
    var idLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(idLabel)
        idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        idLabel.heightAnchor.constraint(equalToConstant: 44.0)
        idLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension CTableViewCell: BindableCell {
    static func makeBinder(value: C) -> CellBinder {
        return CellBinder(
            cellType: CTableViewCell.self,
            registrationMethod: .class(CTableViewCell.self),
            reuseIdentifier: "CTableViewCell",
            configureCell: { (cell) in
                cell.idLabel.text = "\(value.id)"
        })
    }
}
