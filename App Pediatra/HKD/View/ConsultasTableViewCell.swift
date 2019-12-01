//
//  PendientesTableViewCell.swift
//  HKD
//
//  Created by Macbook Air on 9/24/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit

class ConsultasTableViewCell: UITableViewCell {
    @IBOutlet weak var lbIdConsulta: UILabel!
    @IBOutlet weak var lbDependiente: UILabel!
    @IBOutlet weak var lbPadre: UILabel!
    @IBOutlet weak var lbRelacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
