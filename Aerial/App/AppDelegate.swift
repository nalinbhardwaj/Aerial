//
//  AppDelegate.swift
//  Aerial Test
//
//  Created by John Coates on 10/23/15.
//  Copyright © 2015 John Coates. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    //lazy var preferencesWindowController: PreferencesWindowController = PreferencesWindowController()
    var preferencesWindowController: PreferencesWindowController

    /*func applicationWillTerminate(_ notification: Notification) {
        debugLog("Received application will terminate")
        preferencesWindowController.close(self)
    }*/

    override init() {
        preferencesWindowController = PreferencesWindowController()
        print("pwc : \(preferencesWindowController)")
        super.init()

    }

    func applicationDidFinishLaunching(_ notification: Notification) {

        let objects = objectsFromNib(loadNibNamed: "PreferencesWindow")
        preferencesWindowController.appMode = true
        // We need to find the correct window in our nib
        let object = objects.first { object in
            if let window = object as? NSWindow, window.identifier?.rawValue == "preferencesWindow" {
                return true
            }
            return false
        }

        if let window = object as? NSWindow {
            setUp(preferencesWindow: window)
        }
    }

    private func setUp(preferencesWindow window: NSWindow) {
        window.makeKeyAndOrderFront(self)
        window.styleMask = [.closable, .titled, .miniaturizable]

        var frame = window.frame
        frame.origin = window.frame.origin
        window.setFrame(frame, display: true)
    }

    private func objectsFromNib(loadNibNamed nibName: String) -> [AnyObject] {
        let bundle = Bundle.main
        var topLevelObjects: NSArray? = NSArray()
        print("bundle \(bundle)")

        let res =  Bundle.main.loadNibNamed(nibName, owner: preferencesWindowController, topLevelObjects: &topLevelObjects)

        /*let res = bundle.loadNibNamed(nibName,
                                          owner: preferencesWindowController,
                                          topLevelObjects: &topLevelObjects)
         */
        print("res")
        return topLevelObjects! as [AnyObject]
    }
}
