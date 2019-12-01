//
//  ViewController.swift
//  HKD
//
//  Created by Macbook Air on 14/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import Eureka
import NotificationBannerSwift
import JWTDecode

class LoginViewController: FormViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear diseño de módulo.
        createForm()
        tableView.backgroundColor = .white
        tableView.sectionIndexColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
    }
    
    func createForm() {
        form
            +++ LabelRow(){ row in }
            <<< ButtonRow() { (row: ButtonRow) in
                row.title = "INICIO DE SESIÓN"
                }.cellSetup() {cell, row in
                     cell.tintColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 28)
            }
            
            <<< LabelRow(){ row in }
            
            <<< EmailRow() { row in
                row.placeholder = "Correo electrónico:"
                row.tag = "txtCorreo"
                row.add(rule: RuleRequired(msg: "Este campo es obligatorio."))
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
                })
            
            <<< LabelRow(){ row in }
            
            <<< PasswordRow() { row in
                row.placeholder = "Contraseña:"
                row.tag = "txtContra"
                row.add(rule: RuleRequired(msg: "Este campo es obligatorio."))
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellSetup({ (cell, row) in
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
                })
            
            
            <<< LabelRow(){ row in }
            
            <<< ButtonRow() { (row: ButtonRow) in
                row.title = "ENTRAR"
                }.cellSetup() {cell, row in
                    cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
                    cell.tintColor = UIColor.white
                }.onCellSelection({ (cell, row) in
                
                    if self.validarForm(){

                        let usuario = Usuario()
                        usuario.email = (self.form.rowBy(tag: "txtCorreo") as! EmailRow).value
                        usuario.password = (self.form.rowBy(tag: "txtContra") as! PasswordRow).value

                        // Enviar a identificación.
                        DaoUsuario().login(user: usuario){ success, id, string, name, last, msg in
                            if (success!) {
                                self.navigationController?.visibleViewController?.removeFromParent()
                                ConfigureDefaults().onUserLogin(id: id!, token: string!)
                                ConfigureDefaults().setNameUser(name: name!)
                                ConfigureDefaults().setLastnameUser(lastname: last!)
//                                print("Token: \(string!)")
//                                print("Id: \(id!)")
                            }
                            else
                            {
                                let banner = NotificationBanner(title: "Inicio de sesión", subtitle: msg, style: .danger)
                                banner.show()
                            }

                            if ConfigureDefaults().getTokenUser() != "" && ConfigureDefaults().getTokenUser() != "nothing"
                            {
                               self.entrarApp()
                            }
                        }
                    }
                    else
                    {
                        let banner = NotificationBanner(title: "Inicio de sesión", subtitle: "Escriba su correo electrónico y contraseña para continuar.", style: .danger)
                        banner.show()
                    }
                })
        
            <<< LabelRow(){ row in }
            <<< LabelRow(){ row in }
            
            +++ ButtonRow() { row in
                row.title = "¿Aún no tienes cuenta?"
                }.cellSetup({ (cell, row) in
                    cell.tintColor = .black
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                })
            
            <<< ButtonRow() { row in
                row.title = "Registrate aquí."
                }.cellUpdate({ (cell,row) in
                    cell.tintColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                }).onCellSelection({ (cell, row) in
                    self.irRegistro()
                })
        
    }
    
    func validarForm() -> Bool{
        return (self.form.rowBy(tag: "txtCorreo") as! EmailRow).value != "" && (self.form.rowBy(tag: "txtCorreo") as! EmailRow).value != nil &&  (self.form.rowBy(tag: "txtContra") as! PasswordRow).value != "" && (self.form.rowBy(tag: "txtContra") as! PasswordRow).value != nil
    }
    
    func entrarApp()  {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    func irRegistro()  {
        performSegue(withIdentifier: "toRegistroUsuario", sender: self)
    }
}

