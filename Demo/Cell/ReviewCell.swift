//
//  ReviewCell.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit
import DataSourceKit

final class ReviewCell: CollectionViewFullWidthCell {
    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
}

extension ReviewCell: BindableCell {
    static func makeBinder(value review: Review) -> CellBinder {
        return CellBinder(
            cellType: ReviewCell.self,
            registrationMethod: .nib(UINib(nibName: "ReviewCell", bundle: nil)),
            reuseIdentifier: "Review",
            configureCell: { cell in
                cell.authorImageView.image = review.authorImage
                cell.authorNameLabel.text = review.authorName
                cell.bodyLabel.text = review.body
            })
    }
}
