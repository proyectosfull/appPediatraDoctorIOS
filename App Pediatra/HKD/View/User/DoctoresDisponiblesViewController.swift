//
//  DoctoresDisponiblesViewController.swift
//  HKD
//
//  Created by Macbook Air on 25/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import Eureka

class DoctoresDisponiblesViewController: FormViewController{

    
    @IBOutlet weak var doctoresDisponiblesCollectionView: UICollectionView!
    
   // var medicos: [Medico] = []
    var selectedMedico: Medico = Medico()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear diseño de módulo.
      createForm()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        self.tabBarController?.navigationItem.title = "PEDIATRAS"
    }
    
    func createForm()  {
        DaoPediatra().obtainList(){ medicosJson, success in
        var medicos: [Medico] = []
            let doc = Medico()
        
            
//            for obj in medicosJson {
//
//                doc.id = obj["id"].intValue
//                doc.nombre = obj["nombreCompleto"].stringValue
//                doc.consultorio?.atiendeEn = obj["lugarAtencion"]["tipo"].stringValue
//                doc.consultorio?.direccion = obj["lugarAtencion"]["direccion"].stringValue
//                doc.especialidad?.nombre = obj["especialidad"]["nombre"].stringValue
//                doc.consultorio?.latitud = obj["lugarAtencion"]["latitud"].stringValue
//                doc.consultorio?.longitud = obj["lugarAtencion"]["longitud"].stringValue
//
//                medicos.append(doc)
            
                
                self.form +++ LabelRow() { row in
                        row.title = doc.nombre
                    
                        }.cellSetup() {cell, row in
                            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
                            cell.textLabel?.textAlignment = .right
                            cell.imageView?.image = #imageLiteral(resourceName: "image_doctor")
                            cell.height = ({ return 65})
                        }
                
                    <<< LabelRow() { row in
                        row.title = doc.especialidad?.nombre
                        }.cellSetup() {cell, row in
                                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
                                cell.textLabel?.textAlignment = .right
                                cell.tintColor = UIColor.black
                                cell.height = ({ return 30 })
                            }
                        <<< LabelRow() { row in
                            row.title = doc.consultorio?.atiendeEn

                            }.cellSetup() {cell, row in
                                cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
                                cell.textLabel?.textAlignment = .right
                                cell.tintColor = UIColor.black
                                   cell.height = ({ return 30 })
                            }
               
                    <<< ButtonRow() { (row: ButtonRow) in
                        row.title = doc.consultorio?.direccion

                    }.cellSetup() {cell, row in
                        cell.imageView?.image = #imageLiteral(resourceName: "icono_mapa")
                        cell.imageView?.sizeToFit()
                        cell.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
                        
                        cell.textLabel?.adjustsFontSizeToFitWidth = true
                        cell.backgroundColor = .blue
                        cell.tintColor = UIColor.white
                        cell.textLabel?.numberOfLines = 2

                        cell.height = ({ return 45 })
                }
//                self.form +++ ButtonRow() { (row: ButtonRow) in
//                    row.title = doc.nombre
//
//                    }.cellSetup() {cell, row in
//                        cell.imageView?.image = #imageLiteral(resourceName: "image_doctor")
//                        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
//                        cell.backgroundColor = .none
//                        cell.tintColor = UIColor.black
//
//                        cell.height = ({ return 110 })
//                }
            //}
            
           
        }
    }

    
//    func loadMedicosEstaticos(){
//        let medico1 = Medico()
//        medico1.id = 1
//        medico1.email = "jos@gmail.com"
//        medico1.password = "password1"
//        medico1.nombre = "José"
//        medico1.apellidos = "Mendoza Jimenez"
//        medico1.nacimiento = "12-12-1970"
//        medico1.cedula = "AE_29392"
//        medico1.disponibilidad = 1
//        medico1.sesion = 1
//        medico1.tarifa = 60.0
//        medico1.fotografia = nil
//        medico1.firetoken = "bhvhcrreee444ADW"
//        medico1.fechaRegistro = "26-03-2019"
//        medico1.consultorio?.id = 1
//        medico1.consultorio?.latitud = "18.840090"
//        medico1.consultorio?.longitud = "-99.184355"
//        medico1.consultorio?.direccion = "No Reelección 101, Centro, 62760 Emiliano Zapata, Mor."
//        medico1.consultorio?.atiendeEn = "Casa"
//        medico1.consultorio?.fechaRegistro = "26-03-2019"
//        medico1.especialidad?.id = 1
//        medico1.especialidad?.nombre = "Pediatria"
//        medico1.especialidad?.fechaRegistro = "26-03-2019"
//
//        let medico2 = Medico()
//        medico2.id = 2
//        medico2.email = "dan@gmail.com"
//        medico2.password = "password2"
//        medico2.nombre = "Daniel"
//        medico2.apellidos = "Fernandez Rodriguez"
//        medico2.nacimiento = "11-11-1975"
//        medico2.cedula = "BC_30403"
//        medico2.disponibilidad = 1
//        medico2.sesion = 1
//        medico2.tarifa = 80.0
//        medico2.fotografia = nil
//        medico2.firetoken = "jhvhgffeeefshb"
//        medico2.fechaRegistro = "27-03-2019"
//        medico2.consultorio?.id = 2
//        medico2.consultorio?.latitud = "18.882049"
//        medico2.consultorio?.longitud = "-99.177003"
//        medico2.consultorio?.direccion = "CARLOS HECO S/N, Centro, 62550 Jiutepec, Mor."
//        medico2.consultorio?.atiendeEn = "Clinica Particular"
//        medico2.consultorio?.fechaRegistro = "27-03-2019"
//        medico2.especialidad?.id = 1
//        medico2.especialidad?.nombre = "Pediatria"
//        medico2.especialidad?.fechaRegistro = "26-03-2019"
//
//        let medico3 = Medico()
//        medico3.id = 3
//        medico3.email = "xoc@gmail.com"
//        medico3.password = "password3"
//        medico3.nombre = "Xochitl"
//        medico3.apellidos = "Jimenez Lopez"
//        medico3.nacimiento = "10-10-1980"
//        medico3.cedula = "CD_41514"
//        medico3.disponibilidad = 0
//        medico3.sesion = 1
//        medico3.tarifa = 90.0
//        medico3.fotografia = nil
//        medico3.firetoken = "ggccggjbnkgdSQ45"
//        medico3.fechaRegistro = "28-03-2019"
//        medico3.consultorio?.id = 3
//        medico3.consultorio?.latitud = "18.921163"
//        medico3.consultorio?.longitud = "-99.237539"
//        medico3.consultorio?.direccion = "José Ma. Morelos y Pavón 271, Cuernavaca Centro, Centro, 62000 Cuernavaca, Mor."
//        medico3.consultorio?.atiendeEn = "Casa"
//        medico3.consultorio?.fechaRegistro = "28-03-2019"
//        medico3.especialidad?.id = 1
//        medico3.especialidad?.nombre = "Pediatria"
//        medico3.especialidad?.fechaRegistro = "26-03-2019"
//
//        medicos.append(medico1)
//        medicos.append(medico2)
//        medicos.append(medico3)
//
//        doctoresDisponiblesCollectionView.reloadData()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return medicos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let identifier = "doctoresDisponiblesCollectionViewCell"
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DoctoresDisponiblesCollectionViewCell
//        //cell.dotor = medicos[indexPath.row]
//        cell.lblNombre.text = medicos[indexPath.row].nombre! + " " + medicos[indexPath.row].apellidos!
//        cell.lblAtiende.text = "Atiende: " + (medicos[indexPath.row].consultorio?.atiendeEn)!
//        cell.lblDireccion.text = "Dirección: " + (medicos[indexPath.row].consultorio?.direccion)!
//        if medicos[indexPath.row].disponibilidad == 1{
//            cell.imgvDisponible.image = UIImage(named: "tick")
//        }
//        cell.btnMap.tag = indexPath.row
//        cell.btnMap.addTarget(self, action: #selector(toMapSegue), for: UIControl.Event.touchUpInside)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("lol")
//    }
//
//    @IBAction func toMapSegue(_ sender: UIButton){
//        selectedMedico = medicos[sender.tag]
//        performSegue(withIdentifier: "toMap", sender: self)
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "toMap"?:
//            let vistaDestino = segue.destination as! MapViewController
//            vistaDestino.selectedMedico = self.selectedMedico
//        default:
//            break
//        }
//    }

}
