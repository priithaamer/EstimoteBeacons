//
//  ViewController.swift
//  EstimoteBeacons
//
//  Created by Priit Haamer on 09.08.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import UIKit

let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")

class ViewController: UIViewController, ESTBeaconManagerDelegate {
    
    let beaconManager = ESTBeaconManager()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestAlwaysAuthorization()
        
        var region = ESTBeaconRegion(proximityUUID: uuid, identifier: "region")
        
        beaconManager.delegate = self
        beaconManager.avoidUnknownStateBeacons = true
        
        beaconManager.startMonitoringForRegion(region)
        beaconManager.requestStateForRegion(region)
        
        // beaconManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func beaconManager(manager: ESTBeaconManager!, didEnterRegion region: ESTBeaconRegion!) {
        NSLog("Did enter region")
        
        // present local notification
        var notification = UILocalNotification()
        notification.alertBody = "Tere tulemast!"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    func beaconManager(manager: ESTBeaconManager!, didExitRegion region: ESTBeaconRegion!) {
        NSLog("Did exit region")
        
        var notification = UILocalNotification()
        notification.alertBody = "Nägemist!"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    func beaconManager(manager: ESTBeaconManager!, didDetermineState state: CLRegionState, forRegion region: ESTBeaconRegion!) {
        NSLog("Did determine state")
        
        if state == .Inside {
            NSLog("State is inside")
        } else {
            NSLog("State is outside")
        }
    }

    // func beaconManager(manager: ESTBeaconManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: ESTBeaconRegion!) {
    //     NSLog("Found \(beacons.count) beacons in range")
    // }
}

