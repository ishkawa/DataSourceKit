//
//  AdvancedVenueDetailViewController.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class AdvancedVenueDetailViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let dataSource = CollectionViewDataSource<AdvancedVenueDetailViewState.CellDeclaration> { cellDeclaration in
        switch cellDeclaration {
        case .outline(let venue):
            return VenueOutlineCell.makeBinder(value: venue)
        case .sectionHeader(let title):
            return SectionHeaderCell.makeBinder(value: title)
        case .review(let review):
            return ReviewCell.makeBinder(value: review)
        case .relatedVenue(let venue):
            return RelatedVenueCell.makeBinder(value: venue)
        }
    }
    
    private var state = AdvancedVenueDetailViewState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.dataSource = dataSource
        
        dataSource.cellDeclarations = state.cellDeclarations
    }
}
