//
//  UIView+Frame.swift
//  CollectionViewAdapter
//
//  Created by Dima Korolev on 03/01/17.
//  Copyright © 2017 dimakorol. All rights reserved.
//

import UIKit

extension UIView {
  var width: CGFloat {
    set {
      if newValue < 0 { return }
      frame = CGRect(origin: frame.origin, size: CGSize(width: newValue, height: height))
    }
    
    get {
      return frame.width
    }
  }
  
  var height: CGFloat {
    set {
      if newValue < 0 { return }
      frame = CGRect(origin: frame.origin, size: CGSize(width: width, height: newValue))
    }
    
    get {
      return frame.height
    }
  }
}
