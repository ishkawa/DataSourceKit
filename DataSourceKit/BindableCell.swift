//
//  BindableCell.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import Foundation

public protocol BindableCell {
    associatedtype Value
    static func makeBinder(value: Value) -> CellBinder
}
