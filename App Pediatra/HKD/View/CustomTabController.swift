//
//  CustomTabController.swift
//  HKD
//
//  Created by Macbook Air on 4/30/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import UIKit

class CustomTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if !ConfigureDefaults().checkIfBabySelected() {
//            self.selectedIndex = 0
//            ActionSheetHelper.showActionBaby(viewController: self)
//        }
//    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//        if !ConfigureDefaults().checkIfBabySelected() {
//            selectedIndex = 0
//            ActionSheetHelper.showActionBaby(viewController: self)
//        }
    }

    @IBAction func selectBaby(_ sender: Any) {
         //ActionSheetHelper.selectBaby(viewController: self)
    }
}
