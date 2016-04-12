//
//  DelegateCollectionCell.swift
//  test
//
//  Created by Dima Korolev on 10/04/16.
//  Copyright © 2016 Dima Korolev. All rights reserved.
//

import UIKit

public class DelegateCollectionCell: UICollectionViewCell, CellViewBinder {
    public var cellId: String {
        fatalError("Override property cellId in subclass of DelegateCollectionCell")
    }
    
    public var cellClass: AnyClass {
        return self.dynamicType
    }
    
    public func bindData(cell: UICollectionViewCell, cellData: Any) {
        bindData(cellData)
    }
    
    public func bindData(cellData: Any) {
        fatalError("Override func bindData in subclass of DelegateCollectionCell")
    }
}