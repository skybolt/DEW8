//
//  Shared.swift
//  DEW 8
//
//  Created by rob on 5/10/18.
//  Copyright © 2018 rob. All rights reserved.
//

/* to do list 2018-05-14
 Show counters:
 background refresh counter
 complication refresh counter
 add both to modular large complication
 title of modular large is last counter clear time
 add counter clear function
 set refreshes for 10 mintes, 15 minutes, do not exhuast refresh budget, if there even is one
 */

import Foundation

struct globalVars {
    static var bgRefreshCounter = 0
    static var bgSnapshotCounter = 0
    static var lastCounterClear = Date()
    static var lastSnapshotTask = Date()
    static var lastBackgroundTask = Date()
    static var oldStatusString = "N"
    static var newStatusString = "N"
}

final class sharedObjects: NSObject {

    static func fullDebug(file: String = #file, line: Int = #line, function: String = #function, DateCalled: Date = Date()) -> String {
        return "\(file):\(line) : \(function) on \(DateCalled)"
    }
    
    
    static func simpleDebug(function: String = #function, dateCalled: Date = Date()) -> String {
        return "function: : \(function) on \(dateCalled)"
    }
    
}
