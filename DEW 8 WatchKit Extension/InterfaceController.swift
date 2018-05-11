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


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user

//        let okAction = WKAlertAction(title: "OK", style: .default) { }
//        self.presentAlert(withTitle: sharedObjects.debug(),
//                          message: "okAction",
//                          preferredStyle: .alert, actions: [okAction])

        super.willActivate()
    }
    
    override func didDeactivate() {

    }

}
