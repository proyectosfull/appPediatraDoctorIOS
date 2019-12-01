//
//  Consulta.swift
//  HKD
//
//  Created by Macbook Air on 4/10/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class Consulta {
    
    var id: Int? = nil
    var temperatura: Double? = nil
    var peso: Double? = nil
    var sintomas: String? = nil
    var aceptado: Int? = nil
    var pagado: Int? = nil
    var fechaRegistro: String? = nil
    var atendido: Int? = nil
    var fechaAtendido: String? = nil
    var medico: Medico? = nil
    var usuario: Usuario? = nil
    var dependiente: Dependiente? = nil
    var pago: Pago? = nil
    var receta: Receta? = nil
    
    var comprobantePago: Archivo? = nil
    var fotos = [Archivo]()
}
