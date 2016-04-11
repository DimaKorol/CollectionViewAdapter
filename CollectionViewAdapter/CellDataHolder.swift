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


public extension SequenceType{
    func toCellDataHolder(type : Int) -> [CellDataHolder] {
        var data = [CellDataHolder]()
        for item in self{
            data.append(CellDataHolder(type: type, data: item as! AnyObject))
        }
        return data
    }
}