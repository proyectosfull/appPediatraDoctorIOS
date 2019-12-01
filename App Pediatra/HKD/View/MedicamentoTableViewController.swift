//
//  MedicamentoTableViewController.swift
//  HKD
//
//  Created by Macbook Air on 10/1/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import SwiftyJSON
import NotificationBannerSwift

class MedicamentoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var medicamentoTableView: UITableView!
    public var medicamentoList: [RecetaDetalle] = [RecetaDetalle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                if controller is DetallePendientesViewController
                {
                    medicamentoList = (controller as! DetallePendientesViewController).receta
                }
                
                if controller is DetalleRealizadasViewController
                {
                    medicamentoList = (controller as! DetalleRealizadasViewController).receta
                }
            }
        }
        self.medicamentoTableView.sectionHeaderHeight = 0
        self.medicamentoTableView.sectionFooterHeight = 0
       
        self.tabBarController?.navigationItem.title = "MEDICAMENTOS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicamentoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicamentoCell", for: indexPath) as! MedicamentosTableViewCell
        
        cell.lbNombre.text = medicamentoList[indexPath.row].medicamento
        cell.lbDosis.text = medicamentoList[indexPath.row].dosis
        cell.lbIntervalo.text = medicamentoList[indexPath.row].intervaloDeTiempo
        cell.lbDuracion.text = medicamentoList[indexPath.row].duracionTratamiento
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "MEDICAMENTOS"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            medicamentoList.remove(at: indexPath.row)
            medicamentoTableView.beginUpdates()
            medicamentoTableView.deleteRows(at: [indexPath], with: .middle)
            medicamentoTableView.endUpdates()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                if controller is DetallePendientesViewController
                {
                    (controller as! DetallePendientesViewController).receta = medicamentoList 
                }
            }
        }
    }
}
