//
//  DelegateCollectionCell.swift
//  test
//
//  Created by Dima Korolev on 10/04/16.
//  Copyright © 2016 Dima Korolev. All rights reserved.
//

import UIKit

class DelegateCollectionCell: UICollectionViewCell, CellViewBinder {
    var cellId: String {
        fatalError("Override property cellId in subclass of DelegateCollectionCell")
    }
    
    var cellClass: AnyClass {
        return self.dynamicType
    }
    
    func bindData(cell: UICollectionViewCell, cellData: AnyObject) {
        bindData(cellData)
    }
    
    func bindData(cellData: AnyObject) {
        fatalError("Override func bindData in subclass of DelegateCollectionCell")
    }
}