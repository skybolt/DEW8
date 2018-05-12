//
//  Shared.swift
//  DEW 8
//
//  Created by rob on 5/10/18.
//  Copyright © 2018 rob. All rights reserved.
//

import Foundation

final class sharedObjects: NSObject {

    static func fullDebug(file: String = #file, line: Int = #line, function: String = #function) -> String {
        return "\(file):\(line) : \(function)"
    }
    
    
    static func simpleDebug(function: String = #function) -> String {
        return "function: : \(function)"
    }
    
}
