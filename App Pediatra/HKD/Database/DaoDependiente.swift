//
//  DaoDependiente.swift
//  HKD
//
//  Created by Macbook Air on 4/19/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import NotificationBannerSwift

class DaoDependiente{

    // Enviar datos de dependiente a registro.
    func save(depend: Dependiente, success: @escaping (Bool)-> ()) {
        
        let name: String! = depend.nombre
        let lastname: String! = depend.apellidos
        let date: String! = depend.nacimiento?.toString(format: "yyyy-MM-dd")
        let note: String! = depend.notas
        let sex: Int! = depend.genero
        let paren: Int! = depend.relacion
        let token: String! = String(ConfigureDefaults().getTokenUser())
     
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        let parameters = [
            "dependiente": [
                "nombre": name,
                "apellidos": lastname,
                "fecha_nacimiento": date,
                "notas": note,
                "sexo": sex
            ],
            "parentesco": paren
            ] as [String : Any]
        
         let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/dependiente/nuevo")! as URL,
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
        print(success)
    }
    
    func getAll() -> [Dependiente]{
        var dependientes: [Dependiente] = []
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        // 2
        let fetchRequest : NSFetchRequest<DependienteDB> = DependienteDB.fetchRequest()
        //fetchRequest.sortDescriptors = [NSSortDescriptor.init(key:"id", ascending: false)]
        //3
        do
        {
            let results = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for result in results {
                let dependienteAux: Dependiente = Dependiente()
                dependienteAux.id = result.value(forKey: "id") as? Int
                dependienteAux.nombre = result.value(forKey: "nombre") as? String
                dependienteAux.apellidos = result.value(forKey: "apellidos") as? String
                dependienteAux.genero = result.value(forKey: "genero") as? Int
                dependienteAux.notas = result.value(forKey: "notas") as? String
                dependienteAux.nacimiento = result.value(forKey: "nacimiento") as? Date
                dependienteAux.fotografia = result.value(forKey: "fotografia") as? URL
                dependienteAux.fechaRegistro = result.value(forKey: "fechaRegistro") as? Date
                dependienteAux.relacion = result.value(forKey: "relacion") as? Int
                dependienteAux.codigo = result.value(forKey: "codigo") as? String
                dependienteAux.idUsuario = result.value(forKey: "idUsuario") as? Int
                dependientes.insert(dependienteAux, at: 0)
            }
        }catch let error as NSError{
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        return dependientes
    }
    
    
    func getAllByUsuario(usuario: Int) ->[Dependiente]{
        var dependientes: [Dependiente] = []
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        // 2
        let fetchRequest : NSFetchRequest<DependienteDB> = DependienteDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idUsuario = %ld", usuario)
        //fetchRequest.sortDescriptors = [NSSortDescriptor.init(key:"id", ascending: false)]
        //3
        do
        {
            let results = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for result in results {
                let dependienteAux: Dependiente = Dependiente()
                dependienteAux.id = result.value(forKey: "id") as? Int
                dependienteAux.nombre = result.value(forKey: "nombre") as? String
                dependienteAux.apellidos = result.value(forKey: "apellidos") as? String
                dependienteAux.genero = result.value(forKey: "genero") as? Int
                dependienteAux.notas = result.value(forKey: "notas") as? String
                dependienteAux.nacimiento = result.value(forKey: "nacimiento") as? Date
                dependienteAux.fotografia = result.value(forKey: "fotografia") as? URL
                dependienteAux.fechaRegistro = result.value(forKey: "fechaRegistro") as? Date
                dependienteAux.relacion = result.value(forKey: "relacion") as? Int
                dependienteAux.codigo = result.value(forKey: "codigo") as? String
                dependienteAux.idUsuario = result.value(forKey: "idUsuario") as? Int
                dependientes.insert(dependienteAux, at: 0)
            }
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        return dependientes
    }
    
    
    func getAllById(idDependiente: Int) -> Dependiente{
        var dependientes: [Dependiente] = []
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        // 2
        let fetchRequest : NSFetchRequest<DependienteDB> = DependienteDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %ld", idDependiente)
        //fetchRequest.sortDescriptors = [NSSortDescriptor.init(key:"id", ascending: false)]
        //3
        do
        {
            let results = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for result in results {
                let dependienteAux: Dependiente = Dependiente()
                dependienteAux.id = result.value(forKey: "id") as? Int
                dependienteAux.nombre = result.value(forKey: "nombre") as? String
                dependienteAux.apellidos = result.value(forKey: "apellidos") as? String
                dependienteAux.genero = result.value(forKey: "genero") as? Int
                dependienteAux.notas = result.value(forKey: "notas") as? String
                dependienteAux.nacimiento = result.value(forKey: "nacimiento") as? Date
                dependienteAux.fotografia = result.value(forKey: "fotografia") as? URL
                dependienteAux.fechaRegistro = result.value(forKey: "fechaRegistro") as? Date
                dependienteAux.relacion = result.value(forKey: "relacion") as? Int
                dependienteAux.codigo = result.value(forKey: "codigo") as? String
                dependienteAux.idUsuario = result.value(forKey: "idUsuario") as? Int
                dependientes.insert(dependienteAux, at: 0)
            }
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        return dependientes.first!
    }
    
    func obtainList(success: @escaping ([JSON], Bool)-> ()) {
        
        let token: String! = String(ConfigureDefaults().getTokenUser())
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://142.91.170.81/HDK/api/dependiente/consulta")! as URL,
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
                    let list = json["data"]["dependientes"].array
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
        print(success)
    }
}
