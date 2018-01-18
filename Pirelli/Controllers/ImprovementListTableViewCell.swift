//
//  ImprovementListTableViewCell.swift
//  Pirelli
//
//  Created by James Faulkner on 12/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit

class ImprovementListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var objectiveCountLabel: UILabel!
    @IBOutlet weak var dateCompiledLabel: UILabel!
    @IBOutlet weak var reporteeLabel: UILabel!
    @IBOutlet weak var tileView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
