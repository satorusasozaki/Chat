//
//  TextCell.swift
//  Chat
//
//  Created by Satoru Sasozaki on 10/28/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
