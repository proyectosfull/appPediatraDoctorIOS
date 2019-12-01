//
//  Usuario.swift
//  HKD
//
//  Created by Macbook Air on 4/10/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class Usuario : Encodable {
    
    var id: Int? = nil
    var email: String? = nil
    var password: String? = nil
    var nombre: String? = nil
    var apellidos: String? = nil
    var CURP: String? = nil
    
    var cedula : String? = nil
    var cedulaEspecialidad : String? = nil
    var cmcp : String? = nil
    
    var lugarEstudios : String? = nil
    
    var fecha_nacimiento: Date? = nil
    var sesion: Int? = nil
    var fireToken: String? = nil
    var fotografia: URL? = nil
    var fechaRegistro: Date? = nil

}
