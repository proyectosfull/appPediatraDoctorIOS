//
//  ExtensionImageView.swift
//  HKD
//
//  Created by Macbook Air on 4/24/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{

    func loadFromURL(fileURL: URL) {
        do{
            let imageData = try Data(contentsOf: fileURL)
            self.image = UIImage(data: imageData)
        }catch{
            print(error)
        }
    }
}
