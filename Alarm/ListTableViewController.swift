//
//  ListTableViewController.swift
//  Alarm
//
//  Created by Patrick Pahl on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, SwitchTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.sharedInstance.alarms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? SwitchTableViewCell            //cast as table view cell

        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]                                                                //drill down to where the alarm is, indexPath.row
        
        cell?.timeLabel.text = alarm.fireTimeAsString                                                                                   //access time label on SwitchTableViewCell
        cell?.nameLabel.text = alarm.name                                                                                               //access name label on SwitchTableViewCell

        cell?.updateWithAlarm(alarm)
        
        return cell ?? SwitchTableViewCell()                                                                                            //nil coalesent, ?? SwitchTableViewCell()
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
       
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]                    //NEED EXPLANATION, drill down twice?
            AlarmController.sharedInstance.deleteAlarm(alarm)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {                          //Explain??????
        
        guard let indexPath = tableView.indexPathForCell(cell) else {return}
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleAlarm(alarm)
        
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
            //SWITCH CELL SWITCH VALUE CHANGED FUNC : Local Notifications
//        if alarm.enabled {
//            scheduleLocalNotifications(alarm)
//        } else {
//            cancelLocalNotifications(alarm)
//        }

    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        let detailVC = segue.destinationViewController as? DetailTableViewController                                //cast destination view controller as Detail Table View Controller
        if segue.identifier == "toDetail" {                                                                         // segue identifier check?
            guard let indexPath = tableView.indexPathForSelectedRow else {return}                                   //
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            detailVC?.alarm = alarm
        }
    }
}

