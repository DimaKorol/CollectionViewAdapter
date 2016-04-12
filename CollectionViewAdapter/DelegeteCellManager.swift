//
//  DelegeteCellManager.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

public class DelegateCellManager : NSObject{
    weak private var collectionView: UICollectionView?
    
    private var data  = [CellDataHolder](){
        didSet{
            collectionView?.reloadData()
        }
    }
    private var cellBinders = [Int : CellViewBinder]()
    
    public var ownDataSourceDelegate : DKCollectionViewDataSource?
    public var ownViewDelegateFlowLayout : DKCollectionViewDelegateFlowLayout?
    
    
    public init(collectionView : UICollectionView, ownDataSourceDelegate : DKCollectionViewDataSource? = nil, ownViewDelegateFlowLayout : DKCollectionViewDelegateFlowLayout? = nil){
        self.collectionView = collectionView
        super.init()
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        self.ownDataSourceDelegate = ownDataSourceDelegate
        self.ownViewDelegateFlowLayout = ownViewDelegateFlowLayout
    }
    
    public func setData(data : [CellDataHolder]){
        self.data = data
    }
    
    public func addBinder(type : Int, cellViewBinder : CellViewBinder, shouldRegisterClass : Bool) {
        cellBinders[type] = cellViewBinder
        if shouldRegisterClass {
            collectionView?.registerNib(UINib(nibName: String(cellViewBinder.cellClass), bundle: nil), forCellWithReuseIdentifier: cellViewBinder.cellId)
        }
    }
    
    public func removeBinder(type : Int) {
        if let cellViewBinder = cellBinders.removeValueForKey(type) {
            collectionView?.registerClass(nil, forCellWithReuseIdentifier: cellViewBinder.cellId)
        }
    }
    
    public func getCount() -> Int{
        return data.count
    }
    
    func getAllForIndex(index : Int) -> (CellDataHolder, CellViewBinder)? {
        let cellData = data[index]
        
        guard let cellBinder = cellBinders[cellData.type] else {
            return nil
        }
        
        return (cellData, cellBinder)
    }
}

public protocol DKCollectionViewDataSource : UICollectionViewDataSource {
    
}

public protocol DKCollectionViewDelegateFlowLayout : UICollectionViewDelegateFlowLayout {
    
}
