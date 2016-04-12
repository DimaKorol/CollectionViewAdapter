//
//  CellViewBinder.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import UIKit

public protocol CellViewBinder: CellViewBinderDelegates {
    var cellId : String {get}
    var cellClass : AnyClass {get}
    func bindData(cell: UICollectionViewCell, cellData : Any)
}