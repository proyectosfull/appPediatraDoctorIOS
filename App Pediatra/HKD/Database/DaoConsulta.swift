//
//  DaoConsulta.swift
//  HKD
//
//  Created by Macbook Air on 6/23/19.
//  Copyright © 2019 revoktek. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import NotificationBannerSwift
import Foundation

class DaoConsulta {
 
    func obtainList(status: String, success: @escaping ([JSON], Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/consulta/lista?status=\(status)")! as URL,
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
                    let list = json["data"]["consultas"].array
                    print("-> Petición correcta: \(String(describing: ok))")
                    
                    success(list!, ok)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success([JSON](), false)
                }
        }
        print(success)
    }
    
    
    func obtainDetails(id: Int, success: @escaping (JSON, Bool)-> ()) {
        
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/consulta/\(id)")! as URL,
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
                    let ok = json["OK"].stringValue
                    print("-> Petición correcta: \(ok)")
                    success(json,ok.elementsEqual("true") ? true : false)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success(JSON(),false)
                }
        }
        print(success)
    }
    
    func obtainPDF(id: Int, nombre: String, success: @escaping (Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        Alamofire.download(
            NSURL(string: "http://142.91.170.81/HDK/api/multimedia/receta/\(id)/\(nombre)")! as URL,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
            })
        success(true)
//        print(success)
    }
    
    func save(nota: String, receta: [RecetaDetalle], success: @escaping (Bool)-> ()) {
        
        let idConsulta: Int! = ConfigureDefaults().getIdHistorial()
        let idUsuario: Int! = ConfigureDefaults().getIdUser()
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        
       
        var recetaJSON: [Dictionary<String, String>] = [Dictionary<String, String>]()
        
        receta.forEach { (rec) in
            let json: Dictionary<String, String> = [
                "medicamento": rec.medicamento!,
                "dosis": rec.dosis!,
                "intervalo": rec.intervaloDeTiempo!,
                "duracion": rec.duracionTratamiento!
            ]
            recetaJSON.append(json)
        }
        
        let parameters = [
            "consulta": [
                "id": idConsulta
            ],
            "usuario": [
            "id": idUsuario
            ],
            "detalles": recetaJSON,
            "notas": nota
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/consulta/atender")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 100.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        // Petición a API.
        Alamofire.request(request as URLRequest)
            .responseJSON(){ response in
                print("respuesta: \(response)")
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let ok = json["OK"].stringValue
                    print("-> Petición correcta: \(ok)")
                    success(ok.elementsEqual("true") ? true : false)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success(false)
                }
        }
        print(success)
    }
}
