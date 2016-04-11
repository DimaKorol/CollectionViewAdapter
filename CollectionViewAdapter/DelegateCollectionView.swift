//
//  DelegateCollectionView.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

public class DelegateCollectionView: UICollectionView {
    public var manager : DelegateCellManager?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        manager = DelegateCellManager(collectionView: self)
    }
    
    public func setData(data : [CellDataHolder]){
        manager?.setData(data)
    }
    
    public func addBinder(type : Int, cellViewBinder : CellViewBinder, shouldRegisterClass : Bool) {
        manager?.addBinder(type, cellViewBinder: cellViewBinder, shouldRegisterClass: shouldRegisterClass)
    }
    
    public func removeBinder(type : Int) {
        manager?.removeBinder(type)
    }
}

