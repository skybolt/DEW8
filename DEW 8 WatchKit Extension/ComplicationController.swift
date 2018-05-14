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
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        if complication.family == .modularLarge {
            let modLarge = CLKComplicationTemplateModularLargeStandardBody()
//            modLarge.headerTextProvider = CLKSimpleTextProvider(text: String(globalVars.lastCounterClear))
//            modLarge.headerTextProvider = CLKDateTextProvider(date: Date(), units: NSCalendar.Unit.day)
            modLarge.headerTextProvider = CLKTimeTextProvider(date: globalVars.lastCounterClear)
//            modLarge.headerTextProvider.tintColor = globalVars.stringColor
            modLarge.body1TextProvider = CLKSimpleTextProvider(text: String(globalVars.bgRefreshCounter) + " refreshes")
            modLarge.body2TextProvider = CLKSimpleTextProvider(text: String(globalVars.bgSnapshotCounter) + " snapshots")
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: modLarge))
        }
        handler(nil)
    }
    
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
