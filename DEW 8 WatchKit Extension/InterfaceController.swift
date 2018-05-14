//
//  InterfaceController.swift
//  DEW 8 WatchKit Extension
//
//  Created by rob on 5/10/18.
//  Copyright © 2018 rob. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UserNotifications


class InterfaceController: WKInterfaceController {
    
    func counterClear() {
        globalVars.bgRefreshCounter = 0
        globalVars.bgSnapshotCounter = 0
    }
    
//    func registerUserNotificationSettings() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (granted, error) in
//            if granted {
//                UNUserNotificationCenter.current().delegate = self
////                print("⌚️notifications granted")
//            }
////            else {
////                print("⌚️no notifications")
////            }
//        }
//    }
    
//    func registerUserNotificationSettings() {
//        print(sharedObjects.simpleDebug())
//        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (granted, error) in
//            if granted {
//                let viewDewAction = UNNotificationAction(identifier: "viewDewAction", title: "Check Status", options: .foreground)
//                let dewCategory = UNNotificationCategory(identifier: "dewNotifications", actions: [viewDewAction], intentIdentifiers: [], options: [])
//                UNUserNotificationCenter.current().setNotificationCategories([dewCategory])
//                UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//                print("⌚️⌚️⌚️Successfully registered notification support")
//            } else {
//                print("⌚️⌚️⌚️ERROR: \(String(describing: error?.localizedDescription))")
//            }
//        }
//    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
//        registerUserNotificationSettings()
//        let okAction = WKAlertAction(title: "OK", style: .default) { }
//        self.presentAlert(withTitle: sharedObjects.debug(),
//                          message: "okAction",
//                          preferredStyle: .alert, actions: [okAction])

        super.willActivate()
    }
    
    override func didDeactivate() {

    }

}

// Notification Center Delegate
extension InterfaceController: UNUserNotificationCenterDelegate {

}
