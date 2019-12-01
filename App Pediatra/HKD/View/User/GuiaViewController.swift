//
//  GuiaViewController.swift
//  HKD
//
//  Created by Macbook Air on 5/2/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit

class GuiaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var guia: Guia = Guia()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants().guias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "guiaCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GuiaCollectionViewCell
        cell.lblTitulo.text = Constants().guias[indexPath.row].titulo
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guia = Constants().guias[indexPath.row]
        performSegue(withIdentifier: "toShowPDF", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toShowPDF"?:
            let vistaDestino = segue.destination as! PDFViewController
            vistaDestino.guia = self.guia
        default:
            break
        }
    }

}
