//
//  ConfigureDefaults.swift
//  HKD
//
//  Created by Macbook Air on 4/19/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class ConfigureDefaults {

    let defaults = UserDefaults.standard

    func createKeysIfNotExist()->Bool{
        if  UserDefaults.standard.object(forKey: "idUser") == nil ||
            UserDefaults.standard.object(forKey: "userToken") == nil ||
            UserDefaults.standard.object(forKey: "idBaby") == nil ||
            UserDefaults.standard.object(forKey: "idDoc") == nil ||
            UserDefaults.standard.object(forKey: "idHistorial") == nil ||
            UserDefaults.standard.object(forKey: "nameDoc") == nil ||
            UserDefaults.standard.object(forKey: "nameUser") == nil ||
            UserDefaults.standard.object(forKey: "lastnameUser") == nil ||
            UserDefaults.standard.object(forKey: "idReceta") == nil ||
            UserDefaults.standard.object(forKey: "receta") == nil
        {
            defaults.set(-1,forKey:"idUser")
            defaults.set("nothing",forKey:"userToken")
            defaults.set(-1,forKey:"idBaby")
            defaults.set(-1,forKey:"idDoc")
            defaults.set(-1,forKey:"idHistorial")
            defaults.set("",forKey:"nameDoc")
            defaults.set("",forKey:"nameUser")
            defaults.set("",forKey:"lastnameUser")
            defaults.set("",forKey:"receta")
            defaults.set(-1,forKey:"idReceta")
            return false;
        }
        return true;
    }
    
    func isActivedSession() -> Bool {
        if UserDefaults.standard.object(forKey: "userToken") != nil //Si esta iniciado (Hay sesión)
        {
            let token = getTokenUser()
            return !(token.elementsEqual("nothing") || token.elementsEqual(""))
        }
        return false
    }
    
    func onUserLogin(id: Int, token: String){
        defaults.set(id, forKey: "idUser")
        defaults.set(token, forKey: "userToken")
    }
    
    func onUserLogout(){
        defaults.set(-1,forKey:"idUser")
        defaults.set("nothing",forKey:"userToken")
        defaults.set(-1,forKey:"idBaby")
        defaults.set(-1,forKey:"idDoc")
        defaults.set(-1,forKey:"idHistorial")
         defaults.set("",forKey:"nameDoc")
        defaults.set("",forKey:"nameUser")
        defaults.set("",forKey:"lastnameUser")
        defaults.set("",forKey:"receta")
        defaults.set(-1,forKey:"idReceta")
    }
    
    func restart()  {
        defaults.set(-1,forKey:"idBaby")
        defaults.set(-1,forKey:"idDoc")
        defaults.set(-1,forKey:"idHistorial")
        defaults.set("",forKey:"nameDoc")
        defaults.set("",forKey:"receta")
        defaults.set(-1,forKey:"idReceta")
    }
    
    func getIdReceta() -> Int {
        return defaults.integer(forKey: "idReceta")
    }
    
    func setIdReceta(id: Int) {
        defaults.set(id, forKey:"idReceta")
    }
    
    func getReceta() -> String {
        return defaults.string(forKey: "receta")!
    }
    
    func setReceta(receta: String) {
        defaults.set(receta, forKey:"receta")
    }
    
    func getNameUser() -> String {
        return defaults.string(forKey: "nameUser")!
    }
    
    func setNameUser(name: String) {
        defaults.set(name, forKey:"nameUser")
    }
        
    func getLastnameUser() -> String {
        return defaults.string(forKey: "lastnameUser")!
    }
        
    func setLastnameUser(lastname: String) {
        defaults.set(lastname, forKey:"lastnameUser")
    }
    
    func getIdHistorial() -> Int {
        return defaults.integer(forKey: "idHistorial")
    }
    
    func setIdHistorial(id: Int) {
        defaults.set(id, forKey:"idHistorial")
    }
    
    func getIdBaby() -> Int {
        return defaults.integer(forKey: "idBaby")
    }
    
    func setIdBaby(idBaby: Int) {
        defaults.set(idBaby, forKey:"idBaby")
    }
    
    func getIdDoc() -> Int {
        return defaults.integer(forKey: "idDoc")
    }
    
    func setIdDoc(idDoc: Int) {
        defaults.set(idDoc, forKey:"idDoc")
    }
    
    func getNameDoc() -> String {
        return defaults.string(forKey: "nameDoc")!
    }
    
    func setNameDoc(doc: String) {
        defaults.set(doc, forKey:"nameDoc")
    }

    func checkIfBabySelected() -> Bool {
        return getIdBaby() == -1
    }
    func getIdUser() -> Int {
        return defaults.integer(forKey: "idUser")
    }
    
    func getTokenUser() -> String {
        return defaults.object(forKey: "userToken") as! String
    }
    
    //test
    func createAutoIncrementKey(){
        if UserDefaults.standard.object(forKey: "autoIdDependiente") == nil ||
            UserDefaults.standard.object(forKey: "autoIdUser") == nil ||
            UserDefaults.standard.object(forKey: "autoIdCrecimiento") == nil
        {
            defaults.set(1, forKey:"autoIdDependiente")
            defaults.set(1, forKey:"autoIdUser")
            defaults.set(1, forKey:"autoIdCrecimiento")
        }
    }
    
    func autoIncrementIdDependiente() -> Int {
        let value: Int = defaults.integer(forKey: "autoIdDependiente")
        defaults.set(value + 1, forKey:"autoIdDependiente")
        return value
    }
    
    func autoIncrementIdUser() -> Int {
        let value: Int = defaults.integer(forKey: "autoIdUser")
        defaults.set(value + 1, forKey:"autoIdUser")
        return value
    }
    
    func autoIncrementIdCrecimiento() -> Int {
        let value: Int = defaults.integer(forKey: "autoIdCrecimiento")
        defaults.set(value + 1, forKey:"autoIdCrecimiento")
        return value
    }
}
