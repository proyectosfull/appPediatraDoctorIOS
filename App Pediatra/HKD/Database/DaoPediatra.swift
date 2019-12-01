//
//  DaoPediatra.swift
//  HKD
//
//  Created by Macbook Air on 7/2/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class DaoPediatra{
    
    func obtainList(success: @escaping ([JSON], Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/pediatra/lista")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // Petición a API.
        Alamofire.request(request as URLRequest)
            .responseJSON(){ response in
                print("respuesta: \(response)")
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let ok = json["OK"].boolValue
                    let list = json["data"]["pediatras"].array
                    print("-> Petición correcta: \(String(describing: ok))")
                    
//                    var pediatras = [Medico]()
//                    let doc = Medico()
//                    for obj in list! {
//
//                        doc.id = obj["id"].intValue
//                        doc.nombre = obj["nombreCompleto"].stringValue
//                        doc.consultorio?.atiendeEn = obj["lugarAtencion"]["tipo"].stringValue
//                        doc.consultorio?.direccion = obj["lugarAtencion"]["direccion"].stringValue
//                        doc.consultorio?.latitud = obj["lugarAtencion"]["latitud"].stringValue
//                        doc.consultorio?.longitud = obj["lugarAtencion"]["longitud"].stringValue
//                        print(doc.nombre)
//                        pediatras.append(doc)
//                    }
                    success(list!, ok)

                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success([JSON](), false)
                }
        }
        //print(success)
    }
}
