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
        updateBluetoothBasedOnScreen()
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(updateBluetoothBasedOnScreen),
                       name: NSApplication.didChangeScreenParametersNotification,
                       object: nil)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        setBluetooth(on: true) //Turn on bluetooth since we might need it the next time the Mac boots
    }

    @objc func updateBluetoothBasedOnScreen() {
        if NSScreen.screens.count == 1 {
            let screen = NSScreen.screens.first!
            if let id = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? CGDirectDisplayID {
                setBluetooth(on: CGDisplayIsBuiltin(id) == 0)
                return
            }
        }
        setBluetooth(on: false)
    }
}
