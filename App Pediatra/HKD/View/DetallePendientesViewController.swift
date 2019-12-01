//
//  DetalleViewController.swift
//  HKD
//
//  Created by Macbook Air on 9/2/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import Eureka
import NotificationBannerSwift

class DetallePendientesViewController: FormViewController {
    public var receta: [RecetaDetalle] = [RecetaDetalle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createForm()
        tableView.backgroundColor = .white
        tableView.sectionIndexColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        self.tabBarController?.navigationItem.title = "DETALLES"
    }
    
    func createForm()  {
        DaoConsulta().obtainDetails(id: Int(ConfigureDefaults().getIdHistorial())){ historial, success in
            print(historial)
            
            self.form
             
            +++ LabelRow () { row in
                row.title = historial["data"]["consulta"]["dependiente"]["nombreCompleto"].stringValue
                
                row.tag = "lbPaciente"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 2
                    cell.textLabel?.textAlignment = .right
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
            }
            
            <<< LabelRow () { row in
                row.title = "\(historial["data"]["consulta"]["parentesco"].stringValue): \(historial["data"]["consulta"]["usuario"]["nombreCompleto"].stringValue)"
                
                row.tag = "lbRelacion"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 2
                    cell.textLabel?.textAlignment = .right
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
            }
            
            +++ Section ("INFORMACIÓN DEL PACIENTE")
            <<< LabelRow () { row in
                row.title = (historial["data"]["consulta"]["pagado"].stringValue).elementsEqual("false") ? "SIN PAGAR" : "PAGADO"
                
                row.tag = "lbPagado"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 2
                    cell.textLabel?.textAlignment = .right
                    cell.textLabel?.textColor = (historial["data"]["consulta"]["pagado"].stringValue).elementsEqual("false") ? #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1) : #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            }
            
            <<< TextRow () { row in
                row.title = "Fecha de solicitud:"
                row.value = historial["data"]["consulta"]["fecRegistro"].stringValue.components(separatedBy: " ")[0]
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 1
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.isUserInteractionEnabled = false
                    cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
            }
        
            <<< TextRow () { row in
                row.title = "Temperatura y peso:"
                row.value = "\(historial["data"]["consulta"]["temperatura"].stringValue)° - \(historial["data"]["consulta"]["peso"].stringValue)kg."
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 1
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.isUserInteractionEnabled = false
                    cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
            }
            
            <<< TextRow () { row in
                row.title = "Sintomas:"
                row.value = historial["data"]["consulta"]["sintomas"].stringValue
                
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 5
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.isUserInteractionEnabled = false
                    cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
            }
                
            +++ Section ("ATENDER CONSULTA")
            <<< TextRow () { row in
                row.title = "Notas"
                row.tag = "lbNotas"
                row.placeholder = "..."
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
            }
                
            <<< LabelRow () { row in
                row.title = "Receta"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
            }
                
            <<< LabelRow() { (row: LabelRow) in
                row.tag = "lbReceta"
                row.title = (ConfigureDefaults().getReceta().count>0) ? ConfigureDefaults().getReceta() : "Seleccionar una predeterminada...   >"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                }.onCellSelection({ (cell, row) in
                    ConfigureDefaults().setReceta(receta: "")
                    ConfigureDefaults().setIdReceta(id: -1)
                    self.performSegue(withIdentifier: "toRecetas", sender: self)
                })
        
            <<< TextRow () { row in
                row.title = "Medicamento"
                row.tag = "lbMedicamento"
                row.placeholder = "..."
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
            }
            
                <<< TextRow () { row in
                    row.title = "Dósis"
                    row.tag = "lbDosis"
                    row.placeholder = "..."
                    }.cellUpdate() {cell, row in
                        cell.textLabel?.textAlignment = .left
                        cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
            }
            
                <<< TextRow () { row in
                    row.title = "Intervalo de tiempo"
                    row.tag = "lbIntervalo"
                    row.placeholder = "..."
                    }.cellUpdate() {cell, row in
                        cell.textLabel?.textAlignment = .left
                        cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                }
            
                <<< TextRow () { row in
                    row.title = "Duración"
                    row.tag = "lbDuración"
                    row.placeholder = "..."
                    }.cellUpdate() {cell, row in
                        cell.textLabel?.textAlignment = .left
                        cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                }
            
                <<< ButtonRow() { (row: ButtonRow) in
                    row.title = "+ AGREGAR"
                    row.tag = "btnReceta"
                    }.cellUpdate() {cell, row in
                        cell.backgroundColor = .none
                        cell.tintColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.textLabel?.textAlignment = .right
                    }.onCellSelection({ (cell, row) in
                        
                        if
                        (self.form.rowBy(tag: "lbMedicamento") as! TextRow).value == nil ||
                        (self.form.rowBy(tag: "lbDosis") as! TextRow).value == nil ||
                        (self.form.rowBy(tag: "lbIntervalo") as! TextRow).value == nil ||
                        (self.form.rowBy(tag: "lbDuración") as! TextRow).value == nil
                        {
                            let banner = StatusBarNotificationBanner(title: "Capture el medicamento, dósis, intervalo de tiempo y la duración de tratamiento para continuar.", style: .danger)
                            banner.show()
                            return
                        }
                        
                        let med: RecetaDetalle = RecetaDetalle()
                        
                        med.medicamento = (self.form.rowBy(tag: "lbMedicamento") as! TextRow).value!
                        med.dosis = (self.form.rowBy(tag: "lbDosis") as! TextRow).value!
                        med.intervaloDeTiempo = (self.form.rowBy(tag: "lbIntervalo") as! TextRow).value!
                        med.duracionTratamiento = (self.form.rowBy(tag: "lbDuración") as! TextRow).value!
                        
                        self.receta.append(med)
                        let cantidad: Int = self.receta.count
                        (self.form.rowBy(tag: "btnRecetaDetail") as! ButtonRow).title = "\(cantidad) medicamentos agregados."
                        
                        // Reiniciar campos.
                        (self.form.rowBy(tag: "lbMedicamento") as! TextRow).value = ""
                        (self.form.rowBy(tag: "lbDosis") as! TextRow).value = ""
                        (self.form.rowBy(tag: "lbIntervalo") as! TextRow).value = ""
                        (self.form.rowBy(tag: "lbDuración") as! TextRow).value = ""
                        
                        self.tableView.reloadData()
                    })
                
                <<< ButtonRow() { (row: ButtonRow) in
                    row.title = "\(self.receta.count) medicamentos agregados."
                    row.tag = "btnRecetaDetail"
                    }.cellUpdate() {cell, row in
                        cell.backgroundColor = .none
                        cell.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
                        cell.textLabel?.textAlignment = .right
                    }.onCellSelection({ (cell, row) in
                        self.performSegue(withIdentifier: "toMedicin", sender: self)
                    })
            
                +++ ButtonRow() { (row: ButtonRow) in
                row.title = "ENVIAR RESPUESTA"
                }.cellSetup() {cell, row in
                    cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
                    cell.tintColor = UIColor.white
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                }.onCellSelection({ (cell, row) in
                    
                    if self.receta.count == 0{
                        let banner = StatusBarNotificationBanner(title: "Aún no ha capturado los medicamentos para paciente.", style: .danger)
                        banner.show()
                        return
                    }
                    
                    let notas: String = (self.form.rowBy(tag: "lbNotas") as! TextRow).value == nil ? "" : (self.form.rowBy(tag: "lbNotas") as! TextRow).value!
                    
                    // Declare Alert message
                    let dialogMessage = UIAlertController(title: "Confirmar", message: "Se enviará la receta con los medicamentos capturados. ¿Desea continuar?", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "Continuar", style: .default, handler: { (action) -> Void in
                    
                        DaoConsulta().save(nota: notas, receta: self.receta){ success in
                            if (success) {
                                
                                // Reiniciar campos.
                                ConfigureDefaults().setIdReceta(id: -1)
                                ConfigureDefaults().setReceta(receta: "")
                                self.receta = [RecetaDetalle]()
                                self.form.removeAll()
                                self.createForm()
                                self.navigationController?.popViewController(animated: true)
                                
                                let banner = NotificationBanner(title: "Receta médica", subtitle: "La receta ha sido enviada correctamente.", style: .success)
                                banner.show()
                            }
                            else
                            {
                                let banner = NotificationBanner(title: "Receta médica", subtitle: "Ocurrió un error durante el registro.", style: .danger)
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tabBarController?.navigationItem.title = "DETALLES"
        
        if ConfigureDefaults().getIdReceta() != -1
        {
            // Regreso del controlador de Recetas.
            DaoReceta().obtainMedicine(id: "\(ConfigureDefaults().getIdReceta())") { medicamentoJson, success in
                
                medicamentoJson.forEach({ (json) in
                    let med: RecetaDetalle = RecetaDetalle()
                    
                    med.medicamento = json["medicamento"].stringValue
                    med.dosis = json["dosis"].stringValue
                    med.intervaloDeTiempo = json["intervalo"].stringValue
                    med.duracionTratamiento = json["duracion"].stringValue
                    
                    self.receta.append(med)
                })
                
                let cantidad: Int = self.receta.count
                (self.form.rowBy(tag: "btnRecetaDetail") as! ButtonRow).title = "\(cantidad) medicamentos agregados."
                
                self.tableView.reloadData()
                ConfigureDefaults().setIdReceta(id: -1)
                return
                }
            
            (self.form.rowBy(tag: "lbReceta") as! LabelRow).title = (ConfigureDefaults().getIdReceta() == -1) ? "Seleccionar una predeterminada...   >" : ConfigureDefaults().getReceta()
        }else{
            // Regreso del controlador de Medicamentos.
            let cantidad: Int = self.receta.count
            (self.form.rowBy(tag: "btnRecetaDetail") as! ButtonRow).title = "\(cantidad) medicamentos agregados."
        }
    } 
}
