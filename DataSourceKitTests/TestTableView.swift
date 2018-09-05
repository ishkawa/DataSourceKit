//
//  TestTableView.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

class TestTableView: UITableView {
    struct NibRegistration {
        let reuseIdentifier: String
        let nib: UINib?
    }
    
    var nibRegistrations = [] as [NibRegistration]
    
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        super.register(nib, forCellReuseIdentifier: identifier)

        let nibRegistration = NibRegistration(reuseIdentifier: identifier, nib: nib)
        nibRegistrations.append(nibRegistration)
    }
}
