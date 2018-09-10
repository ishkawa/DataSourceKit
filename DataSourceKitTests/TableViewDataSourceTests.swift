//
//  TableViewDataSourceTests.swift
//  DataSourceKitTests
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import Foundation
import XCTest
import DataSourceKit

class TableViewDataSourceTests: XCTestCase {
    enum CellDeclaration {
        case a(A)
        case b(B)
        case c(C)
    }
    
    struct Data: CellsDeclarator {
        var a: [A]
        var b: [B]
        var c: [C]
        
        func declareCells(_ cell: (CellDeclaration) -> Void) {
            for a in a {
                cell(.a(a))
            }
            for b in b {
                cell(.b(b))
            }
            for c in c {
                cell(.c(c))
            }
        }
    }
    
    var dataSource: TableViewDataSource<CellDeclaration>!
    var tableView: TestTableView!
    
    override func setUp() {
        super.setUp()
        
        dataSource = TableViewDataSource<CellDeclaration> { declaration in
            switch declaration {
            case .a(let a):
                return ATableViewCell.makeBinder(value: a)
            case .b(let b):
                return BTableViewCell.makeBinder(value: b)
            case .c(let c):
                return CTableViewCell.makeBinder(value: c)
            }
        }
        
        tableView = TestTableView(frame: UIScreen.main.bounds)
        tableView.dataSource = dataSource
    }
    
    func test() {
        let data = Data(a: [A(id: 1), A(id: 2)], b: [B(id: 1)], c: [C(id: 1)])
        dataSource.cellDeclarations = data.cellDeclarations
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 4)
        XCTAssertEqual(tableView.nibRegistrations.map({ $0.reuseIdentifier }), ["ATableViewCell", "BTableViewCell"])
        XCTAssertEqual(tableView.classRegistrations.map({ $0.reuseIdentifier }), ["CTableViewCell"])
        
        let verifiers: [(UITableViewCell?) -> Void] = [
            { cell in
                let cell = cell as? ATableViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "1")
            },
            { cell in
                let cell = cell as? ATableViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "2")
            },
            { cell in
                let cell = cell as? BTableViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "1")
            },
            { cell in
                let cell = cell as? CTableViewCell
                XCTAssertNotNil(cell)
                XCTAssertEqual(cell?.idLabel.text, "1")
            }
        ]
        
        for (index, verifier) in verifiers.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            verifier(cell)
        }
    }
}
