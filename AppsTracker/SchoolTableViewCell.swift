//
//  SchoolTableViewCell.swift
//  This code defines the custom table view cell for the SchoolTableViewController.
//  AppsTracker
//
//  Created by Sofia Stanescu-Bellu on 1/22/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var schoolCrestView: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var commonAppLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
