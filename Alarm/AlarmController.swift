//
//  AlarmController.swift
//  Alarm
//
//  Created by Patrick Pahl on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//


import UIKit                                                            //Import UIkit for notifications

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



extension AlarmScheduler {
    
    func scheduleLocalNotification(alarm: Alarm) {
        let localNotification = UILocalNotification()               //create instance of UILocalNotification(), *** Remember to import UIKit
        localNotification.alertTitle = "Time to wake up"            //use localnotification . alert title, which is built in to Swift
        localNotification.alertBody = "Get back to work"
        localNotification.fireDate = alarm.fireDate
        localNotification.category = alarm.uuid                     //UUID is a type of *category
        localNotification.repeatInterval = .Day                     //Repeats interval once a day
    }
    
    func cancelLocalNotification(alarm: Alarm){
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else {return}          //guard, creates array of notifications
        for notification in scheduledNotifications {                                                                            //loop through notifications
            if notification.category == alarm.uuid {                                                                            //check if category equals uuid
                UIApplication.sharedApplication().cancelLocalNotification(notification)                                         // cancel
            }
        }
    }
}




