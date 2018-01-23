//
//  ProductionTableViewCell.swift
//  Pirelli
//
//  Created by James Faulkner on 02/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit

class ProductionTableViewCell: UITableViewCell {
    
    // UI Elements
    @IBOutlet weak var machineLabel: UILabel!
    @IBOutlet weak var stopCountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var oeeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
