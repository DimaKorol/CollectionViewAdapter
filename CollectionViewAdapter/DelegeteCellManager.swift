//
//  DelegeteCellManager.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

open class DelegateCellManager : NSObject {
  weak fileprivate var collectionView: UICollectionView?
  
  var templateCells = [String : UICollectionViewCell]()
  var templateCellNibs = [String : UINib]()
  
  fileprivate var data  = [CellDataHolder]() {
    didSet {
      collectionView?.reloadData()
    }
  }
  fileprivate var cellBinders = [Int : CellViewBinder]()
  
  weak open var ownDataSourceDelegate : DKCollectionViewDataSource?
  weak open var ownViewDelegateFlowLayout : DKCollectionViewDelegateFlowLayout?
  
  public var numberRows: Int = 1 {
    didSet{
      collectionView?.reloadData()
    }
  }
  
  public init(collectionView: UICollectionView, ownDataSourceDelegate: DKCollectionViewDataSource? = nil, ownViewDelegateFlowLayout: DKCollectionViewDelegateFlowLayout? = nil) {
    self.collectionView = collectionView
    super.init()
    self.collectionView?.delegate = self
    self.collectionView?.dataSource = self
    
    self.ownDataSourceDelegate = ownDataSourceDelegate
    self.ownViewDelegateFlowLayout = ownViewDelegateFlowLayout
  }
  
  open func setData(_ data: [CellDataHolder]) {
    self.data = data
  }
  
  open func addBinder(_ type: Int, cellViewBinder: CellViewBinder, shouldRegisterCellId: Bool) {
    cellBinders[type] = cellViewBinder
    if Bundle.main.path(forResource: String(describing: cellViewBinder.cellClass), ofType: "nib") != nil {
      let nib = UINib(nibName: String(describing: cellViewBinder.cellClass), bundle: nil)
      templateCellNibs[cellViewBinder.cellId] = nib
      if shouldRegisterCellId {
        collectionView?.register(nib, forCellWithReuseIdentifier: cellViewBinder.cellId)
      }
      
    } else {
      if shouldRegisterCellId {
        collectionView?.register(cellViewBinder.cellClass, forCellWithReuseIdentifier: cellViewBinder.cellId)
      }
      
    }
  }
  
  open func removeBinder(_ type: Int) {
    if let cellViewBinder = cellBinders.removeValue(forKey: type) {
      templateCellNibs[cellViewBinder.cellId] = nil
      collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellViewBinder.cellId)
    }
  }
  
  open func getCount() -> Int {
    return data.count
  }
  
  func cellConfig(forIndex index: Int) -> (data: CellDataHolder, binder: CellViewBinder)? {
    if index >= data.count{
      return nil
    }
    
    let cellData = data[index]
    
    guard let cellBinder = cellBinders[cellData.type] else {
      return nil
    }
    
    return (cellData, cellBinder)
  }
  
  open func getCollectionView() -> UICollectionView? {
    return collectionView
  }
  
  func bindData(_ cell: UICollectionViewCell, cellBinder: CellViewBinder, data: Any) {
    if let delegateCell = cell as? DelegateCollectionCell {
      delegateCell.bindData(cell, cellData: data)
    } else if let delegateCell = cell as? CellViewBinder {
      delegateCell.bindData(cell, cellData: data)
    } else {
      cellBinder.bindData(cell, cellData: data)
    }
  }
  
  func templateCell(_ cellBinder: CellViewBinder) -> UICollectionViewCell? {
    var cell: UICollectionViewCell? = templateCells[cellBinder.cellId]
    if cell == nil {
      if let cellNib = templateCellNibs[cellBinder.cellId] {
        cell = cellNib.instantiate(withOwner: cellBinder, options: nil)[0] as? UICollectionViewCell
      }
      templateCells[cellBinder.cellId] = cell
    }
    return cell
  }
}

public protocol DKCollectionViewDataSource : UICollectionViewDataSource {
  
}

public protocol DKCollectionViewDelegateFlowLayout : UICollectionViewDelegateFlowLayout {
  
}
