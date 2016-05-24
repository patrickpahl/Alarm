//
//  AlarmController.swift
//  Alarm
//
//  Created by Patrick Pahl on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    private let kAlarms = "alarms"
    
    var alarms: [Alarm] = []
    
    init(){
        mockAlarms
    }
    
    var mockAlarms: [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 1000, name: "Alarm 1")
        let alarm2 = Alarm(fireTimeFromMidnight: 1500, name: "Alarm 2")
        
        return [alarm1, alarm2]
    }
    
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    }
    
    
    func deleteAlarm(alarm: Alarm){
        if let indexOfAlarm = alarms.indexOf(alarm){               //create constant, use 'indexOf' to find path
            alarms.removeAtIndex(indexOfAlarm)}                     //remove at index
    }
    
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String){
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }

    func toggleAlarm(alarm: Alarm){
        alarm.enabled = !alarm.enabled
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
                                                                                                        // saving to the device as a directory
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        return entriesPath
    }
    
    func saveToPersistentStorage(){
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(kAlarms))
    }
    
    func loadFromPersistentStorage(){
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kAlarms)) as? [Alarm] else {return}
        self.alarms = alarms
    }
    
}

protocol AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}

extension AlarmScheduler{
    
    func scheduleLocalNotification(alarm: Alarm) {
        let alert 
        
    }
    
    
}


/*
Your scheduleLocalNotification(alarm: Alarm) function should create an instance of a UILocalNotification, give it an alert title, alert body, and fire date. You will also need to set it's category property to something unique (hint: the unique identifier we put on each alarm object is pretty unique). It should also be set to repeat at one day intervals. You will then need to schedule this local notification with the application's shared application.
Your cancelLocalnotification(alarm: Alarm) function will need to get all of the application's scheduled notifications using UIApplication.sharedApplication.scheduledLocalNotifications. This will give you an array of local notifications. You can loop through them and cancel the local notifications whose category matches the alarm using UIApplication.sharedApplication.cancelLocalNotification(notification: notification).
*/


