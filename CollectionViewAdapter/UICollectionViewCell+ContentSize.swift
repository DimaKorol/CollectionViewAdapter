//
//  UICollectionViewCell+ContentSize.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/25/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

public extension UICollectionViewCell{
    func estimateSizeWith(cellBinder : CellViewBinder, collectionViewSize: CGSize) -> CGSize?{
        guard let contentSize = cellBinder.cellSize else{
            return nil
        }
        
        var height: CGFloat
        var width: CGFloat
        if contentSize.valueHeight == contentSize.valueWidth && (contentSize.valueHeight == .WrapContent || contentSize.valueHeight == .MatchContent){
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
            let size = self.contentView.systemLayoutSizeFittingSize(contentSize.valueHeight == .WrapContent ? UILayoutFittingCompressedSize : UILayoutFittingExpandedSize)
            height = size.height
            width = size.width
        } else{
            switch contentSize.valueWidth {
            case .FixedValue(let a):
                width = a
            case .MatchContent:
                width = collectionViewSize.width
            default:
                width = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width
            }
            
            switch contentSize.valueHeight {
            case .FixedValue(let a):
                height = a
            case .MatchContent:
                height = collectionViewSize.height
            default:
                height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            }
        }
        
        if let marginHorizontal = cellBinder.cellMarginHorizontal{
            width -= marginHorizontal
        }
        
        if let marginVertical = cellBinder.cellMarginVertical{
            height -= marginVertical
        }
        
        return CGSizeMake(width, height)
    }
}