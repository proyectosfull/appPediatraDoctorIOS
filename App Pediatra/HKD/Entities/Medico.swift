//
//  Doctor.swift
//  HKD
//
//  Created by Macbook Air on 25/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit

class Medico {
    
    var id: Int? = nil
    var email: String? = nil
    var password: String? = nil
    var nombre: String? = nil
    var apellidos: String? = nil
    var nacimiento: String? = nil
    var cedula: String? = nil
    var disponibilidad: Int? = nil
    var sesion: Int? = nil
    var tarifa: Double? = nil
    var fotografia: UIImage? = nil
    var firetoken: String? = nil
    var fechaRegistro: String? = nil
    let consultorio: Consultorio? = Consultorio()
    let especialidad: Especialidad? = Especialidad()
    
}
