//
//  Guia.swift
//  HKD
//
//  Created by Macbook Air on 5/3/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class Guia {
    
    var id: Int? = nil
    var titulo: String? = nil
    var pag: Int? = nil
    var archivo: String? = nil

    init() {
    }
    
    init(id: Int, titulo: String, pag: Int, archivo: String) {
        self.id = id
        self.titulo = titulo
        self.pag = pag
        self.archivo = archivo
    }
}
