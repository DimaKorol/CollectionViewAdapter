//
//  DefaultCollectionViewDelegate.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

extension UIView {
  func copyView<T: UIView>() -> T {
    return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
  }
}

extension DelegateCellManager: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return getCount()
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let (data, binder) = cellConfig(forIndex: indexPath.row) else {
      
      if let cell = ownDataSourceDelegate?.collectionView(collectionView, cellForItemAt: indexPath){
        return cell
      }
      return UICollectionViewCell()
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: binder.cellId, for: indexPath)
    bindData(cell, cellBinder: binder, data: data.data)
    if templateCell(binder) == nil {
      //        let cellCopy: UICollectionViewCell = cell.copyView()
      templateCells[binder.cellId] = cell
      DispatchQueue.global().async {
        Thread.sleep(forTimeInterval: 0.01)
        DispatchQueue.main.async {
          collectionView.reloadData()
        }
      }
    }
    
    return cell
  }
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int{
    if let numberOfSections = ownDataSourceDelegate?.numberOfSections?(in: collectionView){
      return numberOfSections
    }
    return 1
  }
  
  //    // The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
  //    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
  //        if let reusableView = ownDataSourceDelegate?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath){
  //            return reusableView
  //        }
  //        return UICollectionReusableView()
  //    }
  
  @available(iOS 9.0, *)
  public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    if let canMoveItemAtIndexPath = ownDataSourceDelegate?.collectionView?(collectionView, canMoveItemAt: indexPath) {
      return canMoveItemAtIndexPath
    }
    return false
  }
  
  @available(iOS 9.0, *)
  public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    ownDataSourceDelegate?.collectionView?(collectionView, moveItemAt: sourceIndexPath, to : destinationIndexPath)
  }
}
