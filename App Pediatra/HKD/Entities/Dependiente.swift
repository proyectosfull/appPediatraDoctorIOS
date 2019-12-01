//
//  Dependiente.swift
//  HKD
//
//  Created by Macbook Air on 19/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit

class Dependiente{
    //Genero 0=Mujer; 1=Hombre
    
    var id: Int? = nil
    var nombre: String? = nil
    var apellidos: String? = nil
    var nacimiento: Date? = nil
    var codigo: String? = nil
    var fotografia: URL? = nil
    var fechaRegistro: Date? = nil
    var notas: String? = nil
    var genero: Int? = nil
    var relacion: Int? = nil
    var idUsuario: Int? = nil
    var crecimiento: Crecimiento = Crecimiento()
    
}
