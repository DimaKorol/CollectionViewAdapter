//
//  CellDataHolder.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/6/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

open class CellDataHolder {
    open var type : Int
    open var data : Any
    
    public init(type : Int, data : Any){
        self.type = type
        self.data = data
    }
}


public extension Sequence{
    func toCellDataHolder(_ type : Int) -> [CellDataHolder] {
        var data = [CellDataHolder]()
        for item in self{
            data.append(CellDataHolder(type: type, data: item))
        }
        return data
    }
}
