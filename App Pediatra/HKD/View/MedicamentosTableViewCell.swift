//
//  MedicamentosTableViewCell.swift
//  HKD
//
//  Created by Macbook Air on 10/1/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit

class MedicamentosTableViewCell: UITableViewCell {
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbDosis: UILabel!
    @IBOutlet weak var lbIntervalo: UILabel!
    @IBOutlet weak var lbDuracion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
