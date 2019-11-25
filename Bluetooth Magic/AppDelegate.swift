//
//  AppDelegate.swift
//  Bluetooth Magic
//
//  Created by Daniel Witt on 25.11.19.
//  Copyright © 2019 Daniel Witt. All rights reserved.
//

import Cocoa
import IOBluetooth

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func setBluetooth(on: Bool) {
        NSLog("setBluetooth \(on)")
        IOBluetoothPreferenceSetControllerPowerState(on ? 1 : 0)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(screenDidChange),
                       name: NSApplication.didChangeScreenParametersNotification,
                       object: nil)

    }
    
    @objc func screenDidChange(notification: NSNotification){
        setBluetooth(on: NSScreen.screens.count != 1)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

