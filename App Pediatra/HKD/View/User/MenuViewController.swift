//
//  MenuViewController.swift
//  HKD
//
//  Created by Macbook Air on 7/27/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import SidebarOverlay

class ContainerViewController: SOContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuSide = .Right
        self.topViewController = self.storyboard?.instantiateViewControllerWithIdentifier("topScreen")
        self.sideViewController = self.storyboard?.instantiateViewControllerWithIdentifier("leftScreen")
    }
    
}
