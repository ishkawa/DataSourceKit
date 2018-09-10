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
    
    struct ClassRegistration {
        let reuseIdentifier: String
        let cellType: AnyClass?
    }
    
    var nibRegistrations = [] as [NibRegistration]
    var classRegistrations = [] as [ClassRegistration]
    
    override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        super.register(nib, forCellWithReuseIdentifier: identifier)
        
        let nibRegistration = NibRegistration(reuseIdentifier: identifier, nib: nib)
        nibRegistrations.append(nibRegistration)
    }
    
    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        super.register(cellClass, forCellWithReuseIdentifier: identifier)
        
        // The `register(_ cellClass: forCellWithReuseIdentifier:)` method will be called and receiving a `"com.apple.UIKit.shadowReuseCellIdentifier"`
        // reuse identifier when UICollectionView is initiated by `init(frame: collectionViewLayout:)`, I filter it out since it's useless for
        // our testing.
        if identifier == "com.apple.UIKit.shadowReuseCellIdentifier" { return }
        let classRegistration = ClassRegistration(reuseIdentifier: identifier, cellType: cellClass)
        classRegistrations.append(classRegistration)
    }
}
