//
//  LogoViewController.swift
//  HKD
//
//  Created by Macbook Air on 9/1/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import JWTDecode

class LogoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //print("Logo load: \(ConfigureDefaults().getTokenUser())")
            
            self.checkActivedSession()
            if !self.isExpiredToken()
            {
                print(ConfigureDefaults().getTokenUser())
                self.performSegue(withIdentifier: "toInicio", sender: self)
            }
            self.performSegue(withIdentifier: "toLogoLogin", sender: self)
        }
    }
    
    func checkActivedSession() {
        
        if !ConfigureDefaults().isActivedSession()
        {
            ConfigureDefaults().onUserLogout()
        }
    }
    
    func isExpiredToken() -> Bool {
        let token:String = ConfigureDefaults().getTokenUser()
        
        do{
            if token.elementsEqual("nothing") || token.elementsEqual("") {return true}
            
            let jwt = try decode(jwt: token)
            print(("Expired: \(String(describing: jwt.expiresAt))") )
            print(jwt.expired)
            return jwt.expired
        }
        catch{
            return true;
        }
    }
}
