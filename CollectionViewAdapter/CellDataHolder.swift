//
//  CellDataHolder.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

public class CellDataHolder {
    public var type : Int
    public var data : AnyObject
    
    public init(type : Int, data : AnyObject){
        self.type = type
        self.data = data
    }
}