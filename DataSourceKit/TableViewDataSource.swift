//
//  TableViewDataSource.swift
//  DataSourceKit
//
//  Created by Yosuke Ishikawa on 2018/09/05.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

public class TableViewDataSource<CellDeclaration>: NSObject, UITableViewDataSource {
    public var cellDeclarations = [] as [CellDeclaration]
    
    private var registeredReuseIdentifiers = [] as [String]
    private let binderFromDeclaration: (CellDeclaration) -> CellBinder
    
    public init(binderFromDeclaration: @escaping (CellDeclaration) -> CellBinder) {
        self.binderFromDeclaration = binderFromDeclaration
        super.init()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDeclarations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBinder = binderFromDeclaration(cellDeclarations[indexPath.item])
        if !registeredReuseIdentifiers.contains(cellBinder.reuseIdentifier) {
            tableView.register(cellBinder.nib, forCellReuseIdentifier: cellBinder.reuseIdentifier)
            registeredReuseIdentifiers.append(cellBinder.reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellBinder.reuseIdentifier, for: indexPath)
        cellBinder.configureCell(cell)
        
        return cell
    }
}

extension TableViewDataSource where CellDeclaration == CellBinder {
    // Add meaningless parameter to avoid error `Members of constrained extensions
    // cannot be declared @objc`, which is caused by collision to init() of NSObject.
    public convenience init(binderFromBinder: @escaping (CellBinder) -> CellBinder = { $0 }) {
        self.init(binderFromDeclaration: binderFromBinder)
    }
}
