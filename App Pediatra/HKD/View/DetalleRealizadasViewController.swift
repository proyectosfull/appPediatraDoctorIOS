//
//  DetalleRealizadasViewController.swift
//  HKD
//
//  Created by Macbook Air on 10/3/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

import Foundation
import Eureka
import NotificationBannerSwift
import  SwiftyJSON

class DetalleRealizadasViewController: FormViewController {
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
                        cell.textLabel?.numberOfLines = 1
                        cell.textLabel?.textAlignment = .left
                        cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.isUserInteractionEnabled = false
                        cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                }
                
                +++ Section ("DETALLE DE CONSULTA")
                <<< TextRow () { row in
                    row.title = "Nota:"
                    row.value = historial["data"]["consulta"]["notaPediatra"].stringValue
                    row.tag = "lbNotas"
                    row.placeholder = "..."
                    }.cellUpdate() {cell, row in
                        cell.textLabel?.textAlignment = .left
                        cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.isUserInteractionEnabled = false
                        cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                }
                
                <<< TextRow () { row in
                    row.title = "Fecha de atención:"
                    row.value = historial["data"]["consulta"]["fecAtendido"].stringValue.components(separatedBy: " ")[0]
                    }.cellUpdate() {cell, row in
                        cell.textLabel?.numberOfLines = 1
                        cell.textLabel?.textAlignment = .left
                        cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                        cell.isUserInteractionEnabled = false
                        cell.textField?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                }
                
                <<< ButtonRow() { (row: ButtonRow) in
                    row.title = "\(self.receta.count) medicamentos recetados."
                    row.tag = "btnRecetaDetail"
                    }.cellUpdate() {cell, row in
                        cell.backgroundColor = .none
                        cell.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
                        cell.textLabel?.textAlignment = .right
                    }.onCellSelection({ (cell, row) in
                        self.performSegue(withIdentifier: "toMedicin", sender: self)
                    })
            
            
            
            let dictionary = historial["data"]["consulta"]["receta"]["detalles"].arrayValue
            
            dictionary.forEach({ (d) in
                let obj: RecetaDetalle = RecetaDetalle()
                obj.medicamento = d["medicamento"].stringValue
                obj.dosis = d["dosis"].stringValue
                obj.intervaloDeTiempo = d["intervalo"].stringValue
                obj.duracionTratamiento = d["duracion"].stringValue
                
                self.receta.append(obj)
            })
            let cantidad: Int = self.receta.count
            (self.form.rowBy(tag: "btnRecetaDetail") as! ButtonRow).title = "\(cantidad) medicamentos recetados."
            
            self.tableView.reloadData()
//                +++ ButtonRow() { (row: ButtonRow) in
//                    row.title = "ENVIAR RESPUESTA"
//                    }.cellSetup() {cell, row in
//                        cell.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 1)
//                        cell.tintColor = UIColor.white
//                        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
//                    }.onCellSelection({ (cell, row) in
//
//                        // ---
//                    })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tabBarController?.navigationItem.title = "DETALLES"
    }
}
