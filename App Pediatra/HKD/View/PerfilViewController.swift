//
//  PerfilViewController.swift
//  HKD
//
//  Created by Macbook Air on 4/9/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import Eureka
import ImageRow

class PerfilViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear diseño de módulo.
        createForm()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        self.tabBarController?.navigationItem.title = "PERFIL"
    }
    
    func createForm()  {
        form
            
            +++ Section("Cambiar contraseña")
            <<< PasswordRow(){
                $0.title = "Contraseña actual:"
                $0.tag = "txtPwActual"
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                })
            
            <<< PasswordRow(){
                $0.title = "Contraseña nueva:"
                $0.tag = "txtPwNueva"
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                })
            
            <<< PasswordRow(){
                $0.title = "Confirmar contraseña:"
                $0.tag = "txtConfirmar"
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                })
            
            // Botón de enviar solicitud de consulta.
            +++ ButtonRow() { (row: ButtonRow) in
                row.title = "MODIFICAR"
                }.cellSetup() {cell, row in
                    cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.tintColor = UIColor.white
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                }.onCellSelection({ (cell, row) in
                     //Validar campos.
                    if self.validarContraseñaVacia() {
                        let banner = StatusBarNotificationBanner(title: "Aún hay campos por capturar.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    if self.confirmarContraseña() {
                        let banner = StatusBarNotificationBanner(title: "Las contraseñas no coinciden.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    // Declare Alert message
                    let dialogMessage = UIAlertController(title: "Confirmar", message: "La contraseña será modificada. ¿Desea continuar?", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "Continuar", style: .default, handler: { (action) -> Void in
                        DaoUsuario().updatePasssword(oldPassword: (self.form.rowBy(tag: "txtPwActual") as! PasswordRow).value! , newPassword: (self.form.rowBy(tag: "txtPwNueva") as! PasswordRow).value!){ success in
                            if (success) {
                                
                                // Reiniciar campos.
                                self.form.removeAll()
                                self.createForm()
                                
                                let banner = NotificationBanner(title: "Actualización", subtitle: "Su contraseña se modificó correctamente.", style: .success)
                                banner.show()
                            }
                            else
                            {
                                let banner = NotificationBanner(title: "Actualización", subtitle: "Ocurrió un error durante la modificación.", style: .danger)
                                banner.show()
                            }
                        }
                    })
                    
                    // Create Cancel button with action handlder
                    let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) -> Void in
                    }
                    
                    //Add OK and Cancel button to dialog message
                    dialogMessage.addAction(ok)
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    self.present(dialogMessage, animated: true, completion: nil)
                })
        
            +++ Section("  ")
            +++ Section("Editar datos")
            <<< TextRow(){
                $0.title = "Costo de consulta ($):"
                $0.tag = "txtCosto"
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                })
            
            // Botón de enviar solicitud de consulta.
            +++ ButtonRow() { (row: ButtonRow) in
                row.title = "GUARDAR"
                }.cellSetup() {cell, row in
                    cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.tintColor = UIColor.white
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                }.onCellSelection({ (cell, row) in
                    
                    if ((self.form.rowBy(tag: "txtCosto") as! TextRow).value == nil) {
                        let banner = StatusBarNotificationBanner(title: "Capture el costo de su consulta médica.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    // Declare Alert message
                    let dialogMessage = UIAlertController(title: "Confirmar", message: "Se modificará el costo de sus consultas. ¿Desea continuar?", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "Continuar", style: .default, handler: { (action) -> Void in
                        DaoUsuario().updatePrice(price: (self.form.rowBy(tag: "txtCosto") as! TextRow).value! ){ success in
                            if (success) {
                                
                                // Reiniciar campos.
                                self.form.removeAll()
                                self.createForm()
                                
                                let banner = NotificationBanner(title: "Actualización", subtitle: "Su precio de consulta se modificó correctamente.", style: .success)
                                banner.show()
                            }
                            else
                            {
                                let banner = NotificationBanner(title: "Actualización", subtitle: "Ocurrió un error durante la modificación.", style: .danger)
                                banner.show()
                            }
                        }
                    })
                    
                    // Create Cancel button with action handlder
                    let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) -> Void in
                    }
                    
                    //Add OK and Cancel button to dialog message
                    dialogMessage.addAction(ok)
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    self.present(dialogMessage, animated: true, completion: nil)
                })
        
            +++ Section("  ")
            +++ Section("Firma del pediatra")
            <<< ImageRow() { row in
                row.title = "Seleccionar fotografía"
                row.tag = "picFirma"
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.clearAction = .yes(style: UIAlertAction.Style.destructive)
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                })
            
            // Botón de enviar solicitud de consulta.
            +++ ButtonRow() { (row: ButtonRow) in
                row.title = "GUARDAR FIRMA"
                }.cellSetup() {cell, row in
                    cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.tintColor = UIColor.white
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                }.onCellSelection({ (cell, row) in
                    
                    if (self.form.rowBy(tag: "picFirma") as! ImageRow).value == nil{
                        let banner = StatusBarNotificationBanner(title: "Debe capturar la fotografía de su firma.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    // Firma a base64
                    let rowFirma = (self.form.rowBy(tag: "picFirma") as? ImageRow)?.value
                    let imageData: Data? = rowFirma?.jpegData(compressionQuality: 0.4)
                    let firmaString = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
                    let fotoObj: Archivo = Archivo()
                    fotoObj.tipo = "image/jpg"
                    fotoObj.dato = firmaString
                    
                    
                    // Declare Alert message
                    let dialogMessage = UIAlertController(title: "Confirmar", message: "Su firma será modificada. ¿Desea continuar?", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "Continuar", style: .default, handler: { (action) -> Void in
                        DaoUsuario().saveSign(foto: fotoObj){ success in
                            if (success) {
                                
                                // Reiniciar campos.
                                self.form.removeAll()
                                self.createForm()
                                
                                let banner = NotificationBanner(title: "Actualización", subtitle: "Su firma se modificó correctamente.", style: .success)
                                banner.show()
                            }
                            else
                            {
                                let banner = NotificationBanner(title: "Actualización", subtitle: "Ocurrió un error durante la modificación.", style: .danger)
                                banner.show()
                            }
                        }
                    })
                    
                    // Create Cancel button with action handlder
                    let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) -> Void in
                    }
                    
                    //Add OK and Cancel button to dialog message
                    dialogMessage.addAction(ok)
                    dialogMessage.addAction(cancel)
                    
                    // Present dialog message to user
                    self.present(dialogMessage, animated: true, completion: nil)
                })
    }
    
    func validarContraseñaVacia() -> Bool {
        
        return ((self.form.rowBy(tag: "txtPwActual") as! PasswordRow).value == nil)
        || ((self.form.rowBy(tag: "txtPwNueva") as! PasswordRow).value == nil)
        || ((self.form.rowBy(tag: "txtConfirmar") as! PasswordRow).value == nil)
    }
    
    func confirmarContraseña() -> Bool {
        return (self.form.rowBy(tag: "txtPwNueva") as! PasswordRow).value != (self.form.rowBy(tag: "txtConfirmar") as! PasswordRow).value
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "PERFIL"
    }
}
