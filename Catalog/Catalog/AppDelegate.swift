//
//  AppDelegate.swift
//  Catalog
//
//  Created by Uzver on 29/04/2018.
//  Copyright © 2018 Artem Linetskyi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.windows[0].title = "Catalog"
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        DataModel.sharedInstance.saveArray()
        // Insert code here to tear down your application
    }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true;
    }


}

