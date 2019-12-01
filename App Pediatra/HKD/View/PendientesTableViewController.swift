//
//  PendientesTableViewController.swift
//  HKD
//
//  Created by Macbook Air on 9/24/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import SwiftyJSON
import NotificationBannerSwift

class PendientesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var pendientesTableView: UITableView!
    
    public var pendientesList: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        DaoConsulta().obtainList(status: "0") { historialJson, success in
            self.pendientesList = historialJson
            myGroup.leave()
        }
        
        myGroup.notify(queue: .main) {
            self.pendientesTableView.reloadData()
        }
        self.pendientesTableView.sectionHeaderHeight = 0
        self.pendientesTableView.sectionFooterHeight = 0
        self.tabBarController?.navigationItem.title = "CONSULTAS PENDIENTES"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendientesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendientesCell", for: indexPath) as! ConsultasTableViewCell
        
        cell.lbDependiente.text = pendientesList[indexPath.row]["dependiente"]["nombreCompleto"].stringValue
        cell.lbPadre.text = pendientesList[indexPath.row]["usuario"]["nombreCompleto"].stringValue
        cell.lbRelacion.text = pendientesList[indexPath.row]["parentesco"].stringValue
        cell.lbIdConsulta.text = pendientesList[indexPath.row]["id"].stringValue
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
        self.tabBarController?.navigationItem.title = "CONSULTAS PENDIENTES"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! ConsultasTableViewCell
        ConfigureDefaults().setIdHistorial(id: Int(currentCell.lbIdConsulta!.text!)!)
        
    }
}
