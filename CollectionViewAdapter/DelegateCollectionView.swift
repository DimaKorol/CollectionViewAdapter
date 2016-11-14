//
//  DelegateCollectionView.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

open class DelegateCollectionView: UICollectionView {
    open var manager : DelegateCellManager?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        manager = DelegateCellManager(collectionView: self)
    }
    
    open func setData(_ data : [CellDataHolder]){
        manager?.setData(data)
    }
    
    open func addBinder(_ type : Int, cellViewBinder : CellViewBinder, shouldRegisterClass : Bool) {
        manager?.addBinder(type, cellViewBinder: cellViewBinder, shouldRegisterCellId: shouldRegisterClass)
    }
    
    open func removeBinder(_ type : Int) {
        manager?.removeBinder(type)
    }
}

