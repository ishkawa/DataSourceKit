//
//  VenueOutlineCell.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class VenueOutlineCell: CollectionViewFullWidthCell {
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
}

extension VenueOutlineCell: BindableCell {
    static func makeBinder(value venue: Venue) -> CellBinder {
        return CellBinder(
            cellType: VenueOutlineCell.self,
            registrationMethod: .nib(UINib(nibName: "VenueOutlineCell", bundle: nil)),
            reuseIdentifier: "VenueOutline",
            configureCell: { cell in
                cell.photoImageView.image = venue.photo
                cell.nameLabel.text = venue.name
            })
    }
}
