//
//  PagosTableViewCell.swift
//  HKD
//
//  Created by Macbook Air on 10/6/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit

class PagosTableViewCell: UITableViewCell {
    @IBOutlet weak var lbUsuario: UILabel!
    @IBOutlet weak var lbPaciente: UILabel!
    @IBOutlet weak var lbFecha: UILabel!
    @IBOutlet weak var lbIdDependiente: UILabel!
    @IBOutlet weak var lbNombreArchivo: UILabel!
    @IBOutlet weak var lbIdConsulta: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
