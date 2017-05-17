//
//  UICollectionViewCell+ContentSize.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/25/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

public extension UICollectionViewCell {
  func estimateSizeWith(_ cellBinder: CellViewBinder, collectionViewSize: CGSize) -> CGSize? {
    guard let contentSize = cellBinder.cellSize else {
      return nil
    }
    
    var height: CGFloat
    var width: CGFloat
    if contentSize.valueHeight == contentSize.valueWidth
      && (contentSize.valueHeight == .wrapContent || contentSize.valueHeight == .matchContent) {
      //            self.setNeedsLayout()
      //            self.layoutIfNeeded()
      let size = self.contentView.systemLayoutSizeFitting(contentSize.valueHeight == .wrapContent ? UILayoutFittingCompressedSize : UILayoutFittingExpandedSize)
      height = size.height
      width = size.width
    } else {
      switch contentSize.valueWidth {
      case .fixedValue(let a):
        width = a
      case .matchContent:
        width = collectionViewSize.width
      default:
        width = contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
      }
      
      contentView.width = width
      
      switch contentSize.valueHeight {
      case .fixedValue(let a):
        height = a
      case .matchContent:
        height = collectionViewSize.height
      default:
        height = contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
      }
    }
    
    if let marginHorizontal = cellBinder.cellMarginHorizontal {
      width -= marginHorizontal
    }
    
    if let marginVertical = cellBinder.cellMarginVertical {
      height -= marginVertical
    }
    
    return CGSize(width: width, height: height)
  }
}
