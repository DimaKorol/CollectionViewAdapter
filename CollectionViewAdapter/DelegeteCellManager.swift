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
    
    var templateCells = [String : UICollectionViewCell]()
    var templateCellNibs = [String : UINib]()
    
    private var data  = [CellDataHolder](){
        didSet{
            collectionView?.reloadData()
        }
    }
    private var cellBinders = [Int : CellViewBinder]()
    
    weak public var ownDataSourceDelegate : DKCollectionViewDataSource?
    weak public var ownViewDelegateFlowLayout : DKCollectionViewDelegateFlowLayout?
    
    
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
        let nib = UINib(nibName: String(cellViewBinder.cellClass), bundle: nil)
        templateCellNibs[cellViewBinder.cellId] = nib
        if shouldRegisterClass {
            collectionView?.registerNib(nib, forCellWithReuseIdentifier: cellViewBinder.cellId)
        }
    }
    
    public func removeBinder(type : Int) {
        if let cellViewBinder = cellBinders.removeValueForKey(type) {
            templateCellNibs[cellViewBinder.cellId] = nil
            collectionView?.registerNib(nil, forCellWithReuseIdentifier: cellViewBinder.cellId)
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
    
    public func getCollectionView() -> UICollectionView?{
        return collectionView
    }
    
    func bindData(cell: UICollectionViewCell, cellBinder: CellViewBinder, data: Any){
        if let delegateCell = cell as? DelegateCollectionCell {
            delegateCell.bindData(cell, cellData: data)
        } else{
            cellBinder.bindData(cell, cellData: data)
        }
    }

    func templateCell(cellBinder : CellViewBinder) -> UICollectionViewCell{
        var cell: UICollectionViewCell? = templateCells[cellBinder.cellId]
        if cell == nil {
            if let cellNib = templateCellNibs[cellBinder.cellId] {
                cell = cellNib.instantiateWithOwner(nil, options: nil)[0] as? UICollectionViewCell
            } else {
                assertionFailure("\(cellBinder.cellId) is not registered in \(self)")
            }
            templateCells[cellBinder.cellId] = cell
        }
        return cell!
    }
}

public protocol DKCollectionViewDataSource : UICollectionViewDataSource {
    
}

public protocol DKCollectionViewDelegateFlowLayout : UICollectionViewDelegateFlowLayout {
    
}
