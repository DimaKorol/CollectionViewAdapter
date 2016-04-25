//
//  DefaultCollectionViewDelegate.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

extension DelegateCellManager: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getCount()
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let (cellData, cellBinder) = getAllForIndex(indexPath.row) else {
            
            if let cell = ownDataSourceDelegate?.collectionView(collectionView, cellForItemAtIndexPath: indexPath){
                return cell
            }
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellBinder.cellId, forIndexPath: indexPath)
        bindData(cell, cellBinder: cellBinder, data: cellData.data)
        
        return cell
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        if let numberOfSections = ownDataSourceDelegate?.numberOfSectionsInCollectionView?(collectionView){
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
    public func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        if let canMoveItemAtIndexPath = ownDataSourceDelegate?.collectionView?(collectionView, canMoveItemAtIndexPath: indexPath){
            return canMoveItemAtIndexPath
        }
        return false
    }
    
    @available(iOS 9.0, *)
    public func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        ownDataSourceDelegate?.collectionView?(collectionView, moveItemAtIndexPath: sourceIndexPath, toIndexPath : destinationIndexPath)
    }
    
    
    
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        guard let (cellData, cellBinder) = getAllForIndex(indexPath.row) else {
                return defaultSize(collectionView, layout: collectionViewLayout, defaultSizeForItemAtIndexPath: indexPath)
        }
        
        var size : CGSize?
        
        if let autolayout = cellBinder.cellAutoSize where autolayout{
            let cell = templateCell(cellBinder)
            bindData(cell, cellBinder: cellBinder, data: cellData.data)
            size = cell.estimateSizeWith(cellBinder, collectionViewSize: collectionView.frame.size)
            if let correctedSize = cellBinder.cellSize?(collectionView, estimatedSize: size!){
                size = correctedSize
            }
        } else{
            if let newSize = cellBinder.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAtIndexPath: indexPath){
                size = newSize
            }
        }

        guard let resultSize = size else{
            return defaultSize(collectionView, layout: collectionViewLayout, defaultSizeForItemAtIndexPath: indexPath)
        }
        
        return resultSize
    }
    
    func defaultSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, defaultSizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        if let size = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAtIndexPath: indexPath){
            return size
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        if let edge = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, insetForSectionAtIndex: section){
            return edge
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        if let minimumLineSpacing = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAtIndex: section){
            return minimumLineSpacing
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        if let minimumInteritemSpacing = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAtIndex: section){
            return minimumInteritemSpacing
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let headerReferenceSize = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section){
            return headerReferenceSize
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).headerReferenceSize
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let footerReferenceSize = ownViewDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section){
            return footerReferenceSize
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize
    }
    
    
    public func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        guard let cellBinder = getAllForIndex(indexPath.row)?.1,
            shouldHighlightItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldHighlightItemAtIndexPath: indexPath) else {
                
                if let shouldHighlightItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldHighlightItemAtIndexPath: indexPath){
                    return shouldHighlightItemAtIndexPath
                }
                return true
        }
        return shouldHighlightItemAtIndexPath
    }
    
    public func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, didHighlightItemAtIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, didHighlightItemAtIndexPath: indexPath)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, didUnhighlightItemAtIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, didUnhighlightItemAtIndexPath: indexPath)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        guard let cellBinder = getAllForIndex(indexPath.row)?.1,
            shouldSelectItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldSelectItemAtIndexPath: indexPath) else {
                
                if let shouldSelectItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldSelectItemAtIndexPath: indexPath){
                    return shouldSelectItemAtIndexPath
                }
                return true
        }
        return shouldSelectItemAtIndexPath
    }
    
    public func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        guard let cellBinder = getAllForIndex(indexPath.row)?.1,
            shouldDeselectItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldSelectItemAtIndexPath: indexPath) else {
                
                if let shouldDeselectItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldSelectItemAtIndexPath: indexPath){
                    return shouldDeselectItemAtIndexPath
                }
                return true
        }
        
        return shouldDeselectItemAtIndexPath
    }// called when the user taps on an already-selected item in multi-select mode
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, didSelectItemAtIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, didSelectItemAtIndexPath: indexPath)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, didDeselectItemAtIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, didDeselectItemAtIndexPath: indexPath)
        }
    }
    

    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
        }
    }

    public func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, atIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, atIndexPath: indexPath)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, didEndDisplayingCell: cell, forItemAtIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, didEndDisplayingCell: cell, forItemAtIndexPath: indexPath)
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, atIndexPath: indexPath)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, atIndexPath: indexPath)
        }
    }
    
    // These methods provide support for copy/paste actions on cells.
    // All three should be implemented if any are.
    
    public func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        guard let cellBinder = getAllForIndex(indexPath.row)?.1,
            shouldShowMenuForItemAtIndexPath = cellBinder.collectionView?(collectionView, shouldShowMenuForItemAtIndexPath: indexPath) else {
                
                if let shouldShowMenuForItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, shouldShowMenuForItemAtIndexPath: indexPath){
                    return shouldShowMenuForItemAtIndexPath
                }
                return false
        }
        
        return shouldShowMenuForItemAtIndexPath
    }
    
    public func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool{
        guard let cellBinder = getAllForIndex(indexPath.row)?.1,
            canPerformAction = cellBinder.collectionView?(collectionView, canPerformAction:action, forItemAtIndexPath: indexPath, withSender: sender) else {
                
                if let canPerformAction = ownViewDelegateFlowLayout?.collectionView?(collectionView, canPerformAction:action, forItemAtIndexPath: indexPath, withSender: sender){
                    return canPerformAction
                }
                return false
        }
        
        return canPerformAction
    }
    
    public func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?){
        ownViewDelegateFlowLayout?.collectionView?(collectionView, performAction: action, forItemAtIndexPath: indexPath, withSender: sender)
        
        if let cellBinder = getAllForIndex(indexPath.row)?.1 {
            cellBinder.collectionView?(collectionView, performAction: action, forItemAtIndexPath: indexPath, withSender: sender)
        }
    }
    
    // Focus
    @available(iOS 9.0, *)
    public func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        guard let cellBinder = getAllForIndex(indexPath.row)?.1,
            canFocusItemAtIndexPath = cellBinder.collectionView?(collectionView, canFocusItemAtIndexPath: indexPath) else {
                
                if let canFocusItemAtIndexPath = ownViewDelegateFlowLayout?.collectionView?(collectionView, canFocusItemAtIndexPath: indexPath){
                    return canFocusItemAtIndexPath
                }
                return true
        }
        return canFocusItemAtIndexPath
    }

}
