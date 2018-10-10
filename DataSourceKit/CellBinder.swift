//
//  CellBinder.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import Foundation

public struct CellBinder {
    
    public enum RegistrationMethod {
        case nib(UINib)
        case `class`(AnyClass)
        case none
    }
    
    public let registrationMethod: RegistrationMethod
    public let reuseIdentifier: String
    
    internal let configureCell: (Any) -> Void
    
    public init<Cell>(cellType: Cell.Type, registrationMethod: RegistrationMethod, reuseIdentifier: String, configureCell: @escaping (Cell) -> Void) {
        self.registrationMethod = registrationMethod
        self.reuseIdentifier = reuseIdentifier
        self.configureCell = { cell in
            guard let cell = cell as? Cell else {
                fatalError("Could not cast UICollectionView cell to \(Cell.self)")
            }
            
            configureCell(cell)
        }
    }
    
    @available(*, deprecated, message:  "Use `init<Cell>(cellType: Cell.Type, registrationMethod: RegistrationMethod, reuseIdentifier: String, configureCell: @escaping (Cell) -> Void)` instead")
    public init<Cell>(cellType: Cell.Type, nib: UINib, reuseIdentifier: String, configureCell: @escaping (Cell) -> Void) {
        self.init(cellType: cellType, registrationMethod: .nib(nib), reuseIdentifier: reuseIdentifier, configureCell: configureCell)
    }
}
