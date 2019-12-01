//
//  DaoUsuario.swift
//  HKD
//
//  Created by Macbook Air on 5/20/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class DaoUsuario{
    
    let dbEntity: String = "UsuarioDB"

    
    func updatePrice (price: String, success: @escaping (Bool)-> ()){
        let token: String! = String(ConfigureDefaults().getTokenUser())
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        let parameters = [
            "costo": price
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/pediatra/costoconsulta")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
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
    }
    
    // Actualizar contraseña de usuario.
    func updatePasssword (oldPassword: String, newPassword: String, success: @escaping (Bool)-> ()){
        let token: String! = String(ConfigureDefaults().getTokenUser())
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        let parameters = [
            "current_password": oldPassword,
            "new_password": newPassword
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/auth/pediatra/password-restore")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
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
    }
    
    // Enviar datos de usuario a registro.
    func save(user: Usuario, success: @escaping (Bool, String)-> ()) {
       
        let name: String! = user.nombre
        let lastname: String! = user.apellidos
        let curp: String! = user.CURP
        let profesional: String! = user.cedula
        let especial: String! = user.cedulaEspecialidad
        let cmcp: String! = user.cmcp
        let place: String! = user.lugarEstudios
        let email: String! = user.email
        let password: String! = user.password
        let date: String! = user.fecha_nacimiento?.toString(format: "yyyy-MM-dd")
        
        let parameters = [
            "nombre": name,
            "apellidos": lastname,
            "correo": email,
            "password": password,
            "fecha_nacimiento": date,
            "cedula": profesional,
            "cedulaEspecialidad": especial,
            "curp" : curp,
            "cmcp": cmcp,
            "lugarEstudios": place
            ] as [String:String]
        
        // Petición a API.
        Alamofire.request("http://142.91.170.81/HDK/api/pediatra/nuevo",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let ok = json["OK"].stringValue
                        print("-> Petición correcta: \(ok)")
                        success(ok.elementsEqual("true") ? true : false, json["message"].stringValue)
                    
                    case .failure(let error):
                        print("-> La petición falló: \(error)")
                        success(false, "Ocurrió un error durante el registro.")
                }
        }
        print(success)
    }
    
    // Autentificar usuario.
    func login(user: Usuario, success: @escaping (Bool?, Int?, String?, String?, String?, String?) -> ()) {
        let email: String! = user.email
        let password: String! = user.password
    
        let data = [
            "correo": email,
            "password": password,
            "fcm_token": ""
        ] as [String:String]
        
        // Petición a API.
        Alamofire.request("http://142.91.170.81/HDK/api/auth/pediatra/login",
                          method: .post,
                          parameters: data,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let ok = json["OK"].stringValue
                    print("-> Petición correcta: \(ok)")
                    
                    success(ok.elementsEqual("true") ? true : false, json["data"]["pediatra"]["id"].intValue, json["data"]["token"].stringValue, json["data"]["pediatra"]["nombre"].stringValue, json["data"]["pediatra"]["apellidos"].stringValue,
                        json["message"].stringValue)
                    
                case .failure(let error):
                    print("-> La petición falló: \(error)")
                    success(false, 0, nil, nil, nil, "")
                }
        }
    }
    
    // Enviar datos de dependiente a registro.
    func saveSign(foto: Archivo, success: @escaping (Bool)-> ()) {
        let tipo: String! = foto.tipo
        let dato: String! = foto.dato
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        let parameters = [
                "type": tipo,
                "data": dato
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/pediatra/firma")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 300.0)
        request.httpMethod = "PUT"
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
