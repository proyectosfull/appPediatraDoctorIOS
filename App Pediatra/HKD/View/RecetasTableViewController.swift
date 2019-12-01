//
//  RecetasTableViewController.swift
//  HKD
//
//  Created by Macbook Air on 9/30/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecetasTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var recetasTableView: UITableView!
    
    public var recetasList: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        DaoReceta().obtainList() { recetaJson, success in
            self.recetasList = recetaJson
            myGroup.leave()
        }
        
        myGroup.notify(queue: .main) {
            self.recetasTableView.reloadData()
        }
        self.recetasTableView.sectionHeaderHeight = 0
        self.recetasTableView.sectionFooterHeight = 0
        self.tabBarController?.navigationItem.title = "RECETAS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetasList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recetasCell", for: indexPath) as! RecetasTableViewCell
        
        cell.lbReceta.text = recetasList[indexPath.row]["nombre"].stringValue
        cell.lbIdReceta.text = recetasList[indexPath.row]["id"].stringValue
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "RECETAS"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! RecetasTableViewCell
        ConfigureDefaults().setReceta(receta:  currentCell.lbReceta!.text!)
        ConfigureDefaults().setIdReceta(id:  Int(currentCell.lbIdReceta!.text!)!)
        
        self.navigationController?.popViewController(animated: true)
    }
}
