//
//  CellsDeclarator.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/02.
//  Copyright © 2018 Yosuke Ishikawa. All rights reserved.
//

public protocol CellsDeclarator {
    associatedtype CellDeclaration
    func declareCells(_ cell: (CellDeclaration) -> Void)
}

extension CellsDeclarator {
    public var cellDeclarations: [CellDeclaration] {
        var declarations = [] as [CellDeclaration]
        declareCells { declaration in
            declarations.append(declaration)
        }
        return declarations
    }
}
