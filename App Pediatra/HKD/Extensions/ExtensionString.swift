//
//  ExtensionString.swift
//  HKD
//
//  Created by Macbook Air on 14/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation

extension String{
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
