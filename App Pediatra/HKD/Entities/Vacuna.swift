//
//  Vacunacion.swift
//  HKD
//
//  Created by Macbook Air on 28/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class Vacuna {
    
    
    var id: Int? = nil
    var nombre: String? = nil
    var enfermedad: String? = nil
//    var edadRecomendada: Int? = nil
//    var frecuenciaAplicacion: String? = nil
//    var tipoAplicacion: String? = nil
    init(id:Int, nombre:String, enfermedad:String) {
        self.id=id
        self.nombre=nombre
        self.enfermedad=enfermedad
    }
    
}
