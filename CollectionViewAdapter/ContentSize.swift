//
//  ContentSize.swift
//  CollectionViewAdapter
//
//  Created by dimakorol on 4/25/16.
//  Copyright © 2016 dimakorol. All rights reserved.
//

import Foundation

@objc public class ContentSize: NSObject{
    public let valueWidth: ContentParam
    public let valueHeight: ContentParam
    
    public init(width : ContentParam, height : ContentParam){
        valueWidth = width
        valueHeight = height
    }
    
    public static func FixedSize(width: CGFloat, height: CGFloat) -> ContentSize{
        return ContentSize(width: .FixedValue(width), height: .FixedValue(height))
    }
    
    public static func WrapContent() -> ContentSize{
        return ContentSize(width: .WrapContent, height: .WrapContent)
    }
    
    public static func MatchContent() -> ContentSize{
        return ContentSize(width: .MatchContent, height: .MatchContent)
    }
}

public enum ContentParam {
    case FixedValue(CGFloat)
    case WrapContent
    case MatchContent
}

public func ==(a: ContentParam, b: ContentParam) -> Bool {
    switch (a, b) {
    case (.FixedValue(let a),   .FixedValue(let b))  where a == b: return true
    case (.WrapContent, .WrapContent): return true
    case (.MatchContent, .MatchContent): return true
    default: return false
    }
}