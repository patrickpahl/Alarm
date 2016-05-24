//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Patrick Pahl on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        
        delegate?.switchCellSwitchValueChanged(self)
        
    }
    
    func updateWithAlarm(alarm: Alarm){
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}



protocol SwitchTableViewCellDelegate: class {                               //class??
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
    
    
}

