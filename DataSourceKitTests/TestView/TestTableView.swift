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
    
    struct ClassRegistration {
        let reuseIdentifier: String
        let cellClass: AnyClass?
    }
    
    var nibRegistrations = [] as [NibRegistration]
    var classRegistrations = [] as [ClassRegistration]
    
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        super.register(nib, forCellReuseIdentifier: identifier)

        let nibRegistration = NibRegistration(reuseIdentifier: identifier, nib: nib)
        nibRegistrations.append(nibRegistration)
    }
    
    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        super.register(cellClass, forCellReuseIdentifier: identifier)
        
        let classRegistration = ClassRegistration(reuseIdentifier: identifier, cellClass: cellClass)
        classRegistrations.append(classRegistration)
    }
}
