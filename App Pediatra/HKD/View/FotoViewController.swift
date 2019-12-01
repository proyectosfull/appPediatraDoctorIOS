//
//  FotoViewController.swift
//  HKD
//
//  Created by Macbook Air on 10/10/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class FotoViewController: UIViewController{
    private var idbebe: String = ""
    private var archivo: String = ""
    private var id: String = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnComprobar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                if controller is PagosTableViewController
                {
                    self.idbebe = (controller as! PagosTableViewController).idbebe
                    self.archivo = (controller as! PagosTableViewController).archivo
                    self.id = (controller as! PagosTableViewController).id
                }
            }
        }
        
        DaoPago().obtainTokenFiles() { (json, success) in
            let exp: String = json["exp"].stringValue
            let token: String = json["token"].stringValue
            
            let cadena = "http://142.91.170.81/HDK/api/multimedia/consulta/\(String(describing: self.idbebe))/\(exp)/\(token)/\(self.archivo)"
            
            self.imageView.downloaded(from: cadena)
        }
        self.tabBarController?.navigationItem.title = "COMPROBANTE DE PAGO"
    }
    
    @IBAction func confirmar(_ sender: Any) {
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirmar pago", message: "Esta confirmando que el comprobante de pago es válido. ¿Desea continuar?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Continuar", style: .default, handler: { (action) -> Void in
            DaoPago().setStatus(cadena: self.id){ success  in
                if (success) {
                    
                    let banner = NotificationBanner(title: "Confirmación de pago", subtitle: "El comprobante de pago fue confirmado correctamente.", style: .success)
                    banner.show()
                    
                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    let banner = NotificationBanner(title: "Confirmación de pago", subtitle: "Ocurrió un error durante la validación del pago.", style: .danger)
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
    }
}
