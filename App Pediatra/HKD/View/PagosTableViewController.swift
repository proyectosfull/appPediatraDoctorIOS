//
//  PagosTableViewController.swift
//  HKD
//
//  Created by Macbook Air on 10/6/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import SwiftyJSON

class PagosTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var pagosTableView: UITableView!
    public var idbebe: String = ""
    public var archivo: String = ""
    public var id: String = ""
    public var pagosList: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        DaoPago().obtainList() { pagosJson, success in
            self.pagosList = pagosJson
            myGroup.leave()
        }
        
        myGroup.notify(queue: .main) {
            self.pagosList.reverse()
            self.pagosTableView.reloadData()
        }
        self.pagosTableView.sectionHeaderHeight = 0
        self.pagosTableView.sectionFooterHeight = 0
        self.tabBarController?.navigationItem.title = "PAGOS RECIBIDOS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pagosCell", for: indexPath) as! PagosTableViewCell
        
        cell.lbNombreArchivo.text = pagosList[indexPath.row]["nombre"].stringValue
        cell.lbIdConsulta.text = pagosList[indexPath.row]["consulta"]["id"].stringValue
        cell.lbIdDependiente.text = pagosList[indexPath.row]["consulta"]["dependiente"]["id"].stringValue
        cell.lbUsuario.text = pagosList[indexPath.row]["consulta"]["usuario"]["nombreCompleto"].stringValue
        cell.lbPaciente.text = pagosList[indexPath.row]["consulta"]["dependiente"]["nombreCompleto"].stringValue
        cell.lbFecha.text = pagosList[indexPath.row]["consulta"]["fecRegistro"].stringValue.components(separatedBy: " ")[0]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
        self.tabBarController?.navigationItem.title = "PAGOS RECIBIDOS"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! PagosTableViewCell
        //ConfigureDefaults().setIdHistorial(id: Int(currentCell.lbIdConsulta!.text!)!)
        
        idbebe = currentCell.lbIdDependiente.text!
        archivo = currentCell.lbNombreArchivo.text!
        id = currentCell.lbIdConsulta.text!
        performSegue(withIdentifier: "toImagenPago", sender: self)
    }
}
