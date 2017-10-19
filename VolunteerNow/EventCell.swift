//
//  EventCell.swift
//  VolunteerNow
//
//  Created by Macbook on 10/15/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventOrganizer: UILabel!
    @IBOutlet weak var eventDistance: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
