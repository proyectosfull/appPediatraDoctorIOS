//
//  PrincipalView.swift
//  HKD
//
//  Created by Macbook Air on 6/24/19.
//  Copyright © 2019 revoktek. All rights reserved.
//
import Foundation
import  Eureka

class InicioViewController: FormViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureDefaults().restart()
        
        // Crear diseño de módulo.
        createForm()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        self.tabBarController?.navigationItem.title = "INICIO"
    }
    
    func createForm() {
        form
            +++ LabelRow(){rown in}
            
            +++ ButtonRow () { row in
                row.title = "PEDIATRÍA INNOVADORA"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 5
                    cell.textLabel?.textAlignment = .center
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2078431373, green: 0.368627451, blue: 0.7764705882, alpha: 0.81)
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
                     cell.isUserInteractionEnabled = false
            }
            
          
        
            +++ ButtonRow () { row in
                row.title = "Pediatría Innovadora es una App acorde a los nuevos tiempos, en donde tratamos de cubrir las necesidades tanto de los padres como de los profesionales de la Salud responsables del cuidado y manejo de los niños. Mediante el uso de la misma se podrán registrar y consultar los principales datos del crecimiento y desarrollo de nuestros pequeños pacientes, así como llevar el récord de las vacunas aplicadas y enfermedades padecidas con sus respectivos tratamientos. También se podrán emitir recetas básicas las cuales podrán ser impresas por los pacientes para acudir a surtirlas en las farmacias en todos aquellos casos en donde no se tenga la oportunidad de ser atendidos inmediatamente en el consultorio. Esperando pueda ser de utilidad en el manejo “On Line” de nuestros pequeños pacientes te damos la más cordial bienvenida!! \n\nAtte:\nDr. Juan J Diaz Miranda.- Coordinador \n\nDerechos Reservados.\n\nNo. de registro:\n03-2019-070211024300-01 \n03-2019-070211084400-01"
                }.cellUpdate() {cell, row in
                    cell.textLabel?.numberOfLines = 80
                    cell.textLabel?.textAlignment = .justified
                    cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.9580017469)
                     cell.isUserInteractionEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "INICIO"
    }
}
