//
//  DaoReceta.swift
//  HKD
//
//  Created by Macbook Air on 9/30/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Alamofire
import SwiftyJSON

class DaoReceta {
    
    func obtainList(success: @escaping ([JSON], Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/receta")! as URL,
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
                    let list = json["data"]["recetas"].array
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(list!, ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success([JSON](), false)
                }
        }
        print(success)
    }
    
    func obtainMedicine(id: String, success: @escaping ([JSON], Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/receta/\(id)")! as URL,
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
                    let list = json["data"]["medicamentos"].array
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(list!, ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success([JSON](), false)
                }
        }
        print(success)
    }
}
