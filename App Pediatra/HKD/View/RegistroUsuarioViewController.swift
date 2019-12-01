//
//  RegistroUsuarioViewController.swift
//  HKD
//
//  Created by Macbook Air on 14/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//
import UIKit
import NotificationBannerSwift
import Eureka

class RegistroUsuarioViewController: FormViewController {

    var name: String!
    var lastname: String!
    var cedulaProfesional: String!
    var cedulaEspecialidad: String!
    var cmcp: String!
    var dateBirthday: Date!
    var email: String!
    var password: String!
    var confirm: String!

    var usuario = Usuario()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.sectionIndexColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        crearForm()
    }
    
    func crearForm() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        form
            +++ ButtonRow() { (row: ButtonRow) in
                row.title = "REGISTRO DE PEDIATRA"
                }.cellSetup() {cell, row in
                    cell.tintColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 23)
            }
            
            +++ Section("INFORMACIÓN PERSONAL")
            <<< TextRow(){
                $0.title = "Nombre(s):"
                $0.tag = "txtNombre"
                $0.placeholder = "..."
                }
            
            <<< TextRow(){
                $0.title = "Apellidos:"
                $0.tag = "txtApellidos"
                $0.placeholder = "..."
                }
            
            <<< DateInlineRow(){
                $0.title = "Fecha de nacimiento:"
                $0.value = Date() as Date
                $0.tag = "dtFechaNacimiento"
                $0.dateFormatter = dateFormatter
                $0.maximumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
            }
            
            <<< TextRow(){
                $0.title = "CURP:"
                $0.tag = "txtCurp"
                $0.placeholder = "..."
            }
            
            +++ Section("INFORMACIÓN PROFESIONAL")
            <<< TextRow(){
                $0.title = "Cédula profesional:"
                $0.tag = "txtCedProf"
                $0.placeholder = "..."
            }
            
            <<< TextRow(){
                $0.title = "Cédula de especialidad:"
                $0.tag = "txtCedEsp"
                $0.placeholder = "..."
            }
            
            <<< TextRow(){
                $0.title = "CMCP:"
                $0.tag = "txtCmcp"
                $0.placeholder = "..."
            }
            
            <<< TextRow(){
                $0.title = "Lugar de estudios:"
                $0.tag = "txtLugar"
                $0.placeholder = "..."
            }
            
            +++ Section("INFORMACIÓN PARA INICIO DE SESIÓN")
            <<< EmailRow(){
                $0.title = "Correo electrónico:"
                $0.placeholder = "correo@correo.com"
                $0.tag = "txtCorreo"
                }
            
            <<< PasswordRow(){
                $0.title = "Contraseña:"
                $0.tag = "txtContra"
                $0.placeholder = "..."
                }
            
            <<< PasswordRow(){
                $0.title = "Confirmar contraseña:"
                $0.tag = "txtConfirmar"
                $0.placeholder = "..."
                }
            
            +++ ButtonRow() { (row: ButtonRow) in
                row.title = "REGISTRASE"
                }.cellSetup() {cell, row in
                    cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 21)
                    cell.tintColor = UIColor.white
                }.onCellSelection({ (cell, row) in
                    
                    // Validar campos.
                    if self.validarCampos() {
                        let banner = StatusBarNotificationBanner(title: "Aún hay campos vacíos.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    if self.validarContraseña() {
                        let banner = StatusBarNotificationBanner(title: "Las contraseñas no coinciden.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    // Declare Alert message
                    let dialogMessage = UIAlertController(title: "Confirmar", message: "Su información será registrada. ¿Desea continuar?", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "Continuar", style: .default, handler: { (action) -> Void in
                        
                        let usuario = Usuario()
                        // Crear objeto Usuario.
                        usuario.nombre = (self.form.rowBy(tag: "txtNombre") as! TextRow).value
                        usuario.apellidos = (self.form.rowBy(tag: "txtApellidos") as! TextRow).value
                        usuario.CURP = (self.form.rowBy(tag: "txtCurp") as! TextRow).value
                        usuario.cedula = (self.form.rowBy(tag: "txtCedProf") as! TextRow).value
                        usuario.cedulaEspecialidad = (self.form.rowBy(tag: "txtCedEsp") as! TextRow).value
                        usuario.cmcp = (self.form.rowBy(tag: "txtCmcp") as! TextRow).value
                        usuario.lugarEstudios = (self.form.rowBy(tag: "txtLugar") as! TextRow).value
                        usuario.fecha_nacimiento = (self.form.rowBy(tag: "dtFechaNacimiento") as! DateInlineRow).value
                        usuario.email = (self.form.rowBy(tag: "txtCorreo") as! EmailRow).value
                        usuario.password = (self.form.rowBy(tag: "txtContra") as! PasswordRow).value
                        
                        // Registrar nuevo usuario.
                        DaoUsuario().save(user: usuario){ success, msg in
                            if (success) {
                                
                                let banner = NotificationBanner(title: "Registro correcto", subtitle: "Su solicitud de registro fue enviada.", style: .success)
                                banner.show()
                                
                                // Regresar a la vista Login.
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                                    self.irLogin()
                                }
                            }
                            else
                            {
                                let banner = NotificationBanner(title: "Registro de pediatra", subtitle: msg, style: .danger)
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
            
            +++ ButtonRow() { (row: ButtonRow) in
                row.title = "INICIAR SESIÓN"
                }.cellSetup() {cell, row in
                    cell.tintColor = #colorLiteral(red: 0.8470588235, green: 0.1058823529, blue: 0.3764705882, alpha: 1)
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
                }.onCellSelection({ (cell, row) in
                    self.irLogin()
                })
    }
    
    
    func validarCampos() -> Bool {
        return ((form.rowBy(tag: "txtNombre") as! TextRow).value == nil) ||
            ((form.rowBy(tag: "txtApellidos") as! TextRow).value == nil) ||
            ((form.rowBy(tag: "txtCedProf") as! TextRow).value == nil) ||
            ((form.rowBy(tag: "txtCedEsp") as! TextRow).value == nil) ||
            ((form.rowBy(tag: "txtCmcp") as! TextRow).value == nil) ||
            ((form.rowBy(tag: "txtLugar") as! TextRow).value == nil) ||
            
            ((form.rowBy(tag: "txtCorreo") as! EmailRow).value == nil) ||
            ((form.rowBy(tag: "txtContra") as! PasswordRow).value == nil)
    }
    
    func validarContraseña() -> Bool {
        return ((form.rowBy(tag: "txtContra") as! PasswordRow).value) != (form.rowBy(tag: "txtConfirmar") as! PasswordRow).value
    }
    
 
    func irLogin()  {
        performSegue(withIdentifier: "toLoginReg", sender: self)
    }
}
