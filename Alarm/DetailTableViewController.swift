//
//  DetailTableViewController.swift
//  Alarm
//
//  Created by Patrick Pahl on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var alarm: Alarm?
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    
    @IBOutlet weak var alarmNameTextField: UITextField!
    
    @IBOutlet weak var enableButton: UIButton!
    
    
    func updateWithAlarm(alarm: Alarm){
        guard let thisMorningatMidnight = DateHelper.thisMorningAtMidnight else {return}
        alarmDatePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningatMidnight), animated: false)
        alarmNameTextField.text = alarm.name
        self.title = alarm.name
        
    }
    
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else {return}
        AlarmController.sharedInstance.toggleAlarm(alarm)
     //local notif code
        setupView()
    }
   //LOCAL NOTIF CODE
    //if alarm.enabled {
    //            scheduleLocalNotification(alarm)
    //        } else {
    //            cancelLocalNotification(alarm)
    //        }

    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        guard let title = alarmNameTextField.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        let timeIntervalSinceMidnight = alarmDatePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        } else {
            let alarm = AlarmController.sharedInstance.addAlarm(timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
        }
        //local notif code
        self.navigationController?.popViewControllerAnimated(true)
    }
        //LOCAL NOTIF CODE
        //              if let alarm = alarm {
        //            AlarmController.sharedInstance.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        //            cancelLocalNotification(alarm)
        //            scheduleLocalNotification(alarm)
        //        } else {
        //            let alarm = AlarmController.sharedInstance.addAlarm(timeIntervalSinceMidnight, name: title)
        //            self.alarm = alarm
        //            scheduleLocalNotification(alarm)
        //        }
    
    
    func setupView() {
        if alarm == nil {
            enableButton.hidden = true
        } else {
            enableButton.hidden = false
            if alarm?.enabled == true {
                enableButton.setTitle("Disable", forState: .Normal)
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
                enableButton.backgroundColor = .redColor()
            } else {
                enableButton.setTitle("Enable", forState: .Normal)
                enableButton.setTitleColor(.blueColor(), forState: .Normal)
                enableButton.backgroundColor = .grayColor()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        setupView()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
