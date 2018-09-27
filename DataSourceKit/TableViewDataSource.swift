//
//  TableViewDataSource.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

public class TableViewDataSource<CellDeclaration>: NSObject, UITableViewDataSource {

    // MARK: Public Properties

    public typealias Configurator = (CellDeclaration) -> CellBinder
    public var cellDeclarations = [] as [CellDeclaration]

    // MARK: Private Properties

    private var registeredReuseIdentifiers = [] as [String]
    private let binderFromDeclaration: Configurator

    // MARK: Init

    public init(binderFromDeclaration: @escaping Configurator) {
        self.binderFromDeclaration = binderFromDeclaration
        super.init()
    }

    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDeclarations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBinder = binderFromDeclaration(cellDeclarations[indexPath.item])
        if !registeredReuseIdentifiers.contains(cellBinder.reuseIdentifier) {
            switch cellBinder.registrationMethod {
            case let .nib(nib):
                tableView.register(nib, forCellReuseIdentifier: cellBinder.reuseIdentifier)
            case let .class(cellClass):
                tableView.register(cellClass, forCellReuseIdentifier: cellBinder.reuseIdentifier)
            case .none:
                break
            }
            registeredReuseIdentifiers.append(cellBinder.reuseIdentifier)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellBinder.reuseIdentifier, for: indexPath)
        cellBinder.configureCell(cell)

        return cell
    }
}
