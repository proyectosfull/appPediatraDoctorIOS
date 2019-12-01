//
//  RealizadasTableViewController.swift
//  HKD
//
//  Created by Macbook Air on 9/24/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import SwiftyJSON
import NotificationBannerSwift

class RealizadasTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var realizadasTableView: UITableView!
    
    public var realizadasList: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        DaoConsulta().obtainList(status: "1") { historialJson, success in
            self.realizadasList = historialJson
            myGroup.leave()
        }
        
        myGroup.notify(queue: .main) {
            self.realizadasTableView.reloadData()
        }
        self.realizadasTableView.sectionHeaderHeight = 0
        self.realizadasTableView.sectionFooterHeight = 0
        self.tabBarController?.navigationItem.title = "CONSULTAS REALIZADAS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realizadasList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "realizadasCell", for: indexPath) as! ConsultasTableViewCell
        
        cell.lbDependiente.text = realizadasList[indexPath.row]["dependiente"]["nombreCompleto"].stringValue
        cell.lbPadre.text = realizadasList[indexPath.row]["usuario"]["nombreCompleto"].stringValue
        cell.lbRelacion.text = realizadasList[indexPath.row]["parentesco"].stringValue
        cell.lbIdConsulta.text = realizadasList[indexPath.row]["id"].stringValue
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
        self.tabBarController?.navigationItem.title = "CONSULTAS REALIZADAS"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! ConsultasTableViewCell
        ConfigureDefaults().setIdHistorial(id: Int(currentCell.lbIdConsulta!.text!)!)
    }
}
