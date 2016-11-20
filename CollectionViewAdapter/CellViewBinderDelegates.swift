//
//  CellViewBinderDelegates.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/7/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

@objc public protocol CellViewBinderDelegates {
  
  @objc optional var cellAutoSize: Bool {get}
  @objc optional var cellSize: ContentSize {get}
  @objc optional var cellMarginVertical: CGFloat {get}
  @objc optional var cellMarginHorizontal: CGFloat {get}
  @objc optional func cellSize(_ collectionView: UICollectionView, estimatedSize: CGSize) -> CGSize
  
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
  
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
  
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
  
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
  
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
  
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
  
  
  @objc optional func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: IndexPath) -> Bool
  
  @objc optional func collectionView(_ collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: IndexPath)
  
  @objc optional func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: IndexPath)
  
  @objc optional func collectionView(_ collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: IndexPath) -> Bool
  
  @objc optional func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: IndexPath) -> Bool
  
  @objc optional func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath)
  
  @objc optional func collectionView(_ collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: IndexPath)
  
  
  @objc optional func collectionView(_ collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: IndexPath)
  
  @objc optional func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: IndexPath)
  
  @objc optional func collectionView(_ collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: IndexPath)
  
  @objc optional func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: IndexPath)
  
  // These methods provide support for copy/paste actions on cells.
  // All three should be implemented if any are.
  
  @objc optional func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: IndexPath) -> Bool
  
  @objc optional func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: IndexPath, withSender sender: Any?) -> Bool
  
  @objc optional func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: IndexPath, withSender sender: Any?)
  
  // Focus
  @objc @available(iOS 9.0, *)
  optional func collectionView(_ collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: IndexPath) -> Bool
}
