//
//  SearchEventCell.swift
//  VolunteerNow
//
//  Created by Macbook on 10/30/17.
//  Copyright © 2017 Ayush. All rights reserved.
//

import UIKit

class SearchEventCell: UITableViewCell {

    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDistance: UILabel!
    @IBOutlet weak var eventOrganizer: UILabel!
    @IBOutlet weak var eventName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
