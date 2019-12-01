//
//  DaoPago.swift
//  HKD
//
//  Created by Macbook Air on 10/6/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Alamofire
import SwiftyJSON

class DaoPago {
    
    func setStatus(cadena: String, success: @escaping (Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/consulta/pago/\(cadena)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        // Petición a API.
        Alamofire.request(request as URLRequest)
            .responseJSON(){ response in
                print("respuesta: \(response)")
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let ok = json["OK"].boolValue
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success(false)
                }
        }
        print(success)
    }
    
    func obtainList(success: @escaping ([JSON], Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/consulta/pagos")! as URL,
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
                    let list = json["data"]["pagos"].array
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(list!, ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success([JSON](), false)
                }
        }
        print(success)
    }
    
    func obtainImage(cadena: String, success: @escaping (JSON, Bool)-> ()) {
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/multimedia/consulta/\(cadena)")! as URL,
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
                    let list = json["data"]
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(list, ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success(JSON(), false)
                }
        }
        print(success)
    }
    
    func obtainTokenFiles(success: @escaping (JSON, Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/auth/mediatoken")! as URL,
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
                    let list = json["data"]
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(list, ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success(JSON(), false)
                }
        }
        print(success)
    }
    
}
