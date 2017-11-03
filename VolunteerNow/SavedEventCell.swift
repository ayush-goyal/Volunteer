//
//  SavedEventCell.swift
//  VolunteerNow
//
//  Created by Abhinav Piplani on 11/1/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit

class SavedEventCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventOrganizer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        eventName.font = UIFont(name: "Nunito-Bold", size: 17.0)!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
