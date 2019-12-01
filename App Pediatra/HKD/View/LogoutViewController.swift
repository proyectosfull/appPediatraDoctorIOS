//
//  LogoutViewController.swift
//  HKD
//
//  Created by Macbook Air on 6/30/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

class LogoutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureDefaults().onUserLogout()
        self.dismiss(animated: true) {
            self.performSegue(withIdentifier: "toLogout", sender: self)
        }
    }
}
