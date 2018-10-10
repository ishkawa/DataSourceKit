//
//  VenueDetailViewController.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class VenueDetailViewController: UIViewController {
    struct Data: CellsDeclarator {
        var venue: Venue
        var reviews: [Review]
        var relatedVenues: [Venue]
        
        func declareCells(_ cell: (CellBinder) -> Void) {
            cell(VenueOutlineCell.makeBinder(value: venue))
            
            if !reviews.isEmpty {
                cell(SectionHeaderCell.makeBinder(value: "Reviews"))
                for review in reviews {
                    cell(ReviewCell.makeBinder(value: review))
                }
            }
            
            if !relatedVenues.isEmpty {
                cell(SectionHeaderCell.makeBinder(value: "Related Venues"))
                for relatedVenue in relatedVenues {
                    cell(RelatedVenueCell.makeBinder(value: relatedVenue))
                }
            }
        }
    }
    
    static func makeInstance() -> VenueDetailViewController {
        let storyboard = UIStoryboard(name: "VenueDetail", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! VenueDetailViewController
        return viewController
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let dataSource = CollectionViewDataSource()
    
    private var data: Data! {
        didSet {
            dataSource.cellDeclarations = data.cellDeclarations
            collectionView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.dataSource = dataSource

        data = Data(
            venue: Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
            reviews: [
                Review(authorImage: #imageLiteral(resourceName: "ishkawa"), authorName: "Yosuke Ishikawa", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                Review(authorImage: #imageLiteral(resourceName: "yamotty"), authorName: "Masatake Yamoto", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            ],
            relatedVenues: [
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
                Venue(photo: #imageLiteral(resourceName: "Kaminarimon_at_night"), name: "Kaminarimon"),
            ])
    }
}
