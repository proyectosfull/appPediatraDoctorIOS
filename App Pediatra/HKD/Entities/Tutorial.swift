//
//  Tutorial.swift
//  HKD
//
//  Created by Macbook Air on 18/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit

class Tutorial {
    
    var id: Int? = nil
    var titulo: String? = nil
    var uriImage: String? = nil
    var ytId: String? = nil
    var ytURL: String? = nil
    var thumbnail: UIImage? = nil
    
    init() {
    }
    
    
    init(id: Int, titulo: String, uriImage: String, ytId: String, ytURL: String) {
        self.id = id
        self.titulo = titulo
        self.uriImage = uriImage
        self.ytId = ytId
        self.ytURL = ytURL
        
        let url = URL(string: self.uriImage!)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.thumbnail = image
        }

    }
}
