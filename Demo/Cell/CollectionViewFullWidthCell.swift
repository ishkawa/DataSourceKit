//
//  CollectionViewFullWidthCell.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2018/08/31.
//  Copyright © 2018年 Yosuke Ishikawa. All rights reserved.
//

import UIKit

class CollectionViewFullWidthCell: UICollectionViewCell {
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let superview = superview else {
            return layoutAttributes
        }
        
        var targetSize = UIView.layoutFittingCompressedSize
        targetSize.width = floor(superview.frame.width / CGFloat(numberOfColumns))
        
        layoutAttributes.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
        
        return layoutAttributes
    }
    
    var numberOfColumns: Int {
        return 1
    }
}
