//
//  TestCollectionView.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

class TestCollectionView: UICollectionView {
    struct NibRegistration {
        let reuseIdentifier: String
        let nib: UINib?
    }
    
    var nibRegistrations = [] as [NibRegistration]
    
    override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        super.register(nib, forCellWithReuseIdentifier: identifier)
        
        let nibRegistration = NibRegistration(reuseIdentifier: identifier, nib: nib)
        nibRegistrations.append(nibRegistration)
    }
}
