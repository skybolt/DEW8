//
//  ComplicationController.swift
//  DEW 8 WatchKit Extension
//
//  Created by rob on 5/10/18.
//  Copyright © 2018 rob. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func reloadOrExtendData() {
        // 1
//        ExtensionDelegate.checkSessionStatus()
        print(sharedObjects.simpleDebug())
        print(Date().description(with: Locale.current))
        let server = CLKComplicationServer.sharedInstance()
        guard let complications = server.activeComplications,
            complications.count > 0 else { return }
        for complication in complications  {
            server.reloadTimeline(for: complication)
        }
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        if complication.family == .modularLarge {
            let modLarge = CLKComplicationTemplateModularLargeStandardBody()
            let currentString = String(Date().description(with: nil))
            let clearedString = String((globalVars.lastCounterClear).description(with: nil))
//            modLarge.headerTextProvider = CLKTimeTextProvider(date: globalVars.lastCounterClear)
//            modLarge.headerTextProvider = CLKSimpleTextProvider(text: "\(currentString) \(clearedString), \(globalVars.oldStatusString)\(globalVars.newStatusString)")
//            modLarge.headerTextProvider = CLKTimeTextProvider(date: Date())
            print("\(currentString) \(clearedString) \(globalVars.lastBackgroundTask) \(globalVars.lastSnapshotTask)")
//            modLarge.headerTextProvider.tintColor = globalVars.stringColor
//            modLarge.body1TextProvider = CLKSimpleTextProvider(text: String(globalVars.bgRefreshCounter) + " refreshes")
//            modLarge.body2TextProvider = CLKSimpleTextProvider(text: String(globalVars.bgSnapshotCounter) + " snapshots")
////            modLarge.body1TextProvider = CLKTimeTextProvider(date: Date())
//            modLarge.body2TextProvider = CLKTimeTextProvider(date: globalVars.lastCounterClear)
            modLarge.headerTextProvider = CLKSimpleTextProvider(text: "ref: " + String(globalVars.bgRefreshCounter) + ", snp: " + String(globalVars.bgSnapshotCounter) + " " + String(globalVars.oldStatusString) + String(globalVars.newStatusString))
            modLarge.body1TextProvider = CLKTimeTextProvider(date: globalVars.lastBackgroundTask)
            modLarge.body2TextProvider = CLKTimeTextProvider(date: globalVars.lastSnapshotTask)
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: modLarge))
        }
        handler(nil)
    }
//
//    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
//        // Call the handler with the current timeline entry
//        if complication.family == .modularLarge {
//            let modLarge = CLKComplicationTemplateModularLargeStandardBody()
//            let fart = String(Date().description(with: nil))
//            let farter = String((globalVars.lastCounterClear).description(with: nil))
//            modLarge.headerTextProvider = CLKTimeTextProvider(date: globalVars.lastCounterClear)
//            modLarge.headerTextProvider = CLKSimpleTextProvider(text: "\(fart) \(farter)")
//            modLarge.headerTextProvider = CLKTimeTextProvider(date: Date())
//            print("\(fart) \(farter)")
//            //            modLarge.headerTextProvider.tintColor = globalVars.stringColor
//            modLarge.body1TextProvider = CLKSimpleTextProvider(text: String(globalVars.bgRefreshCounter) + " refreshes")
//            modLarge.body2TextProvider = CLKSimpleTextProvider(text: String(globalVars.bgSnapshotCounter) + " snapshots")
//            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: modLarge))
//        }
//        handler(nil)
//    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        //modularLarge template added by RC. Not sure why LargeModularComplication already works if I haven't created a template yet.
        if complication.family == .modularLarge {
            let modLarge = CLKComplicationTemplateModularLargeStandardBody()
            modLarge.headerTextProvider.tintColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            modLarge.headerTextProvider = CLKSimpleTextProvider(text: "no data")
            modLarge.body1TextProvider = CLKSimpleTextProvider(text: "no data")
            modLarge.body2TextProvider = CLKSimpleTextProvider(text: "no data")
            handler(modLarge)
        }
        
        handler(nil)
    }
    
}
