//
//  RecetasTableViewCell.swift
//  HKD
//
//  Created by Macbook Air on 9/30/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit

class RecetasTableViewCell: UITableViewCell {
    @IBOutlet weak var lbIdReceta: UILabel!
    @IBOutlet weak var lbReceta: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
