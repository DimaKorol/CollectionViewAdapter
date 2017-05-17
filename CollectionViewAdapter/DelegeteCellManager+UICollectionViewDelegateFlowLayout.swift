//
//  DelegeteCellManager+UICollectionViewDelegateFlowLayout.swift
//  CollectionViewAdapter
//
//  Created by Dima Korolev on 18/05/2017.
//  Copyright © 2017 dimakorol. All rights reserved.
//

import UIKit

extension DelegateCellManager: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let frame = collectionView.frame
    if numberRows > 1 {
      collectionView.width = frame.width / CGFloat(numberRows) - self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
    }
    guard let (cellData, cellBinder) = cellConfig(forIndex: indexPath.row) else {
      let size = defaultSize(collectionView, layout: collectionViewLayout, defaultSizeForItemAtIndexPath: indexPath)
      collectionView.frame = frame
      return size
    }
    
    var size : CGSize?
    
    if let autolayout = cellBinder.cellAutoSize, autolayout {
      if let cell = templateCell(cellBinder) {
        bindData(cell, cellBinder: cellBinder, data: cellData.data)
        size = cell.estimateSizeWith(cellBinder, collectionViewSize: collectionView.frame.size)
        if let correctedSize = cellBinder.cellSize?(collectionView, estimatedSize: size!){
          size = correctedSize
        }
      }
    } else {
      if let newSize = cellBinder.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAtIndexPath: indexPath){
        size = newSize
      }
    }
    
    let resultSize = size ?? defaultSize(collectionView, layout: collectionViewLayout, defaultSizeForItemAtIndexPath: indexPath)
    
    collectionView.frame = frame
    return resultSize
  }
  
  func defaultSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, defaultSizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    if let size = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) {
      return size
    }
    return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if let edge = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, insetForSectionAt: section) {
      return edge
    }
    return (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if let minimumLineSpacing = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) {
      return minimumLineSpacing
    }
    return (collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    if let minimumInteritemSpacing = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) {
      return minimumInteritemSpacing
    }
    return (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if let headerReferenceSize = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section) {
      return headerReferenceSize
    }
    return (collectionViewLayout as! UICollectionViewFlowLayout).headerReferenceSize
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    if let footerReferenceSize = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section) {
      return footerReferenceSize
    }
    return (collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize
  }
  
  
  public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    guard let cellBinder = cellConfig(forIndex: indexPath.row)?.binder,
      let shouldHighlightItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldHighlightItemAtIndexPath: indexPath) else {
        
        if let shouldHighlightItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldHighlightItemAt: indexPath){
          return shouldHighlightItemAtIndexPath
        }
        return true
    }
    return shouldHighlightItemAtIndexPath
  }
  
  public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, didHighlightItemAt: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, didHighlightItemAtIndexPath: indexPath)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, didUnhighlightItemAtIndexPath: indexPath)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    guard let cellBinder = cellConfig(forIndex: indexPath.row)?.binder,
      let shouldSelectItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldSelectItemAtIndexPath: indexPath) else {
        
        if let shouldSelectItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldSelectItemAt: indexPath){
          return shouldSelectItemAtIndexPath
        }
        return true
    }
    return shouldSelectItemAtIndexPath
  }
  
  public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
    guard let cellBinder = cellConfig(forIndex: indexPath.row)?.binder,
      let shouldDeselectItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldSelectItemAtIndexPath: indexPath) else {
        
        if let shouldDeselectItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldSelectItemAt: indexPath){
          return shouldDeselectItemAtIndexPath
        }
        return true
    }
    
    return shouldDeselectItemAtIndexPath
  }// called when the user taps on an already-selected item in multi-select mode
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, didSelectItemAt: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, didSelectItemAtIndexPath: indexPath)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, didDeselectItemAt: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, didDeselectItemAtIndexPath: indexPath)
    }
  }
  
  
  public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, atIndexPath: indexPath)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, didEndDisplayingCell: cell, forItemAtIndexPath: indexPath)
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, atIndexPath: indexPath)
    }
  }
  
  // These methods provide support for copy/paste actions on cells.
  // All three should be implemented if any are.
  
  public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
    guard let cellBinder = cellConfig(forIndex: indexPath.row)?.binder,
      let shouldShowMenuForItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldShowMenuForItemAtIndexPath: indexPath) else {
        
        if let shouldShowMenuForItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldShowMenuForItemAt: indexPath){
          return shouldShowMenuForItemAtIndexPath
        }
        return false
    }
    
    return shouldShowMenuForItemAtIndexPath
  }
  
  public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
    guard let cellBinder = cellConfig(forIndex: indexPath.row)?.binder,
      let canPerformAction = cellBinder.collectionView?(collectionView, canPerformAction:action, forItemAtIndexPath: indexPath, withSender: sender) else {
        
        if let canPerformAction = ownViewDelegateFlowLayout?.collectionView?(collectionView, canPerformAction:action, forItemAt: indexPath, withSender: sender){
          return canPerformAction
        }
        return false
    }
    
    return canPerformAction
  }
  
  public func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    ownViewDelegateFlowLayout?.collectionView?(collectionView, performAction: action, forItemAt: indexPath, withSender: sender)
    
    if let cellBinder = cellConfig(forIndex: indexPath.row)?.binder {
      cellBinder.collectionView?(collectionView, performAction: action, forItemAtIndexPath: indexPath, withSender: sender)
    }
  }
  
  // Focus
  @available(iOS 9.0, *)
  public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
    guard let cellBinder = cellConfig(forIndex: indexPath.row)?.binder,
      let canFocusItemAtIndexPath = cellBinder.collectionView?(collectionView, canFocusItemAtIndexPath: indexPath) else {
        
        if let canFocusItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, canFocusItemAt: indexPath){
          return canFocusItemAtIndexPath
        }
        return true
    }
    return canFocusItemAtIndexPath
  }
}
