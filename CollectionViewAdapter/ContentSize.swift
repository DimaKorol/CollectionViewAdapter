//
//  ContentSize.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/25/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import Foundation

@objc open class ContentSize: NSObject{
    open let valueWidth: ContentParam
    open let valueHeight: ContentParam
    
    public init(width : ContentParam, height : ContentParam){
        valueWidth = width
        valueHeight = height
    }
    
    open static func FixedSize(_ width: CGFloat, height: CGFloat) -> ContentSize{
        return ContentSize(width: .fixedValue(width), height: .fixedValue(height))
    }
    
    open static func WrapContent() -> ContentSize{
        return ContentSize(width: .wrapContent, height: .wrapContent)
    }
    
    open static func MatchContent() -> ContentSize{
        return ContentSize(width: .matchContent, height: .matchContent)
    }
}

public enum ContentParam {
    case fixedValue(CGFloat)
    case wrapContent
    case matchContent
}

public func ==(a: ContentParam, b: ContentParam) -> Bool {
    switch (a, b) {
    case (.fixedValue(let a),   .fixedValue(let b))  where a == b: return true
    case (.wrapContent, .wrapContent): return true
    case (.matchContent, .matchContent): return true
    default: return false
    }
}
