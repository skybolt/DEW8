//
//  ExtensionDelegate.swift
//  DEW 8 WatchKit Extension
//
//  Created by rob on 5/10/18.
//  Copyright © 2018 rob. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    
    func registerUserNotificationSettings() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (granted, error) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            } //not granted
        } //request closed
    }
    
    func stringWithUUID() -> String {
        let uuidObj = CFUUIDCreate(nil)
        let uuidString = CFUUIDCreateString(nil, uuidObj)!
        return uuidString as String
    }
    
    func throwNotification() {
//        print(sharedObjects.fullDebug())
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.alertSetting == .enabled {
                let notificationContent = UNMutableNotificationContent()
                
                notificationContent.title = self.sessionStatus

                notificationContent.body = "session changes: " + String(self.reachabilityChangeCount) + ", sessions checked: " + String(self.amountChecked)
                notificationContent.sound = UNNotificationSound.default();
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: (0.000001), repeats: false)
                let identifier = self.stringWithUUID()
//                print("identifier = ", terminator: "")
//                print(identifier)
                let notificationRequest = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: notificationTrigger)
                UNUserNotificationCenter.current().add(notificationRequest) { (error) in
//                if let error = error {
//                    print("⌚️ERROR:\(error.localizedDescription)⌚️")
//                } else {
//
//                    print("⌚️Local notification scheduled for", terminator: ": ")
//                    print(Date().description(with: Locale.current), terminator: "")
//                    print("⌚️")
//                    print(notificationTrigger)
//                    }
                }
//                print("notification scheduled")
            }
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        print(sharedObjects.simpleDebug())
    }
    
    //put session delegate did change here.
    
    var reachabilityChangeCount = 0
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        reachabilityChangeCount = reachabilityChangeCount + 1
        throwNotification()
//        print("reachabilityChangeCount = ", terminator: "")
//        print(reachabilityChangeCount)
    }
    
    func applicationDidFinishLaunching() {
        registerUserNotificationSettings()
        // Perform any final initialization of your application.
            if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    var sessionStatus = "not checked"
    
    var amountChecked = 0
    
    func checkSessionStatus() {
        amountChecked = amountChecked + 1
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isReachable {
//                throwNotification()
            } else {
                //do Not Throw Notification
            }
            sessionStatus = String(session.isReachable)
            throwNotification()
        } //WCSession not supported
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        //schedule background task here
        scheduleBGRefresh()
        scheduleBackgroundSnapshot()
        checkSessionStatus()
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func scheduleBGRefresh() {
//        print(sharedObjects.simpleDebug())
        let nextFire = Date(timeIntervalSinceNow: 1 * 1 * 3)
//        print(nextFire)
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: nextFire, userInfo: nil) { _ in }
    }
    
    func scheduleBackgroundSnapshot() {
//        print(sharedObjects.simpleDebug())
        let nextFire = Date(timeIntervalSinceNow: 1 * 1 * 5)
//        print(nextFire)
        WKExtension.shared().scheduleSnapshotRefresh(withPreferredDate: nextFire, userInfo: nil) { _ in }
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
//            print("task is: ", terminator: "")
//            print(task)
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

// Notification Center Delegate
extension ExtensionDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print(sharedObjects.simpleDebug())
//        completionHandler([.sound, .alert])
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print(sharedObjects.simpleDebug())
//        completionHandler()
//    }
}
