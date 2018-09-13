//
//  RelatedVenueCell.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class RelatedVenueCell: CollectionViewFullWidthCell {
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override var numberOfColumns: Int {
        return 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 2
    }
}

extension RelatedVenueCell: BindableCell {
    static func makeBinder(value venue: Venue) -> CellBinder {
        return CellBinder(
            cellType: RelatedVenueCell.self,
            registrationMethod: .nib(UINib(nibName: "RelatedVenueCell", bundle: nil)),
            reuseIdentifier: "RelatedVenue",
            configureCell: { cell in
                cell.photoImageView.image = venue.photo
                cell.nameLabel.text = venue.name
            })
    }
}
