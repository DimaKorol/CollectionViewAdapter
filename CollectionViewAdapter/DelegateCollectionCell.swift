//
//  DelegateCollectionCell.swift
//  CollectionViewAdapter
//
//  Created by Dima Korolev on 10/04/16.
//  Copyright © 2016 Dima Korolev. All rights reserved.
//

import UIKit

open class DelegateCollectionCell: UICollectionViewCell, CellViewBinder {
  open var cellId: String {
    fatalError("Override property cellId in subclass of DelegateCollectionCell")
  }
  
  open var cellClass: AnyClass {
    return type(of: self)
  }
  
  open func bindData(_ cell: UICollectionViewCell, cellData: Any) {
    bindData(cellData)
  }
  
  open func bindData(_ cellData: Any) {
    fatalError("Override func bindData in subclass of DelegateCollectionCell")
  }
}
