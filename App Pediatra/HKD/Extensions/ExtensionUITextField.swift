//
//  ExtensionUITextField.swift
//  HKD
//
//  Created by Macbook Air on 15/03/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func validateLength(fieldName: String,maxLength: Int, minLength: Int) -> Bool {
        if (self.text?.trim().count)! == 0{
            self.setError(fieldDescription: fieldName, textError: errorNoText())
            return false
        }else if (self.text?.trim().count)! < minLength{
            self.setError(fieldDescription: fieldName, textError: errorMinLength(minLength: minLength))
            return false
        }else if (self.text?.trim().count)! > maxLength{
            self.setError(fieldDescription: fieldName , textError: errorMaxLength(maxLength: maxLength))
            return false
        }
        return true
    }
    
    func validateLengthWithoutTrim(fieldName: String,maxLength: Int, minLength: Int) -> Bool {
        if (self.text?.count)! == 0{
            self.setError(fieldDescription: fieldName, textError: errorNoText())
            return false
        }else if (self.text?.count)! < minLength{
            self.setError(fieldDescription: fieldName, textError: errorMinLength(minLength: minLength))
            return false
        }else if (self.text?.count)! > maxLength{
            self.setError(fieldDescription: fieldName , textError: errorMaxLength(maxLength: maxLength))
            return false
        }
        return true
    }
    
    func validateContent(fieldName: String, text: String) -> Bool {
        if self.text == text{
            self.setError(fieldDescription: fieldName, textError: "Valor no valido")
            return true
        }else{
            return false
        }
    }
    func setError(fieldDescription: String, textError: String){
        let color = UIColor(red: 255.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.layer.borderColor = color.cgColor
        self.text = ""
        self.borderStyle = .roundedRect
        self.placeholder = fieldDescription + ": " + textError
    }
    
    func clearError(fieldDescription: String){
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.borderStyle = .roundedRect
        self.placeholder = fieldDescription
    }
    
    func checkConfirmPassword(passwordTextField : UITextField, fieldName: String)->Bool{
        if self.text != passwordTextField.text{
            self.setError(fieldDescription: fieldName, textError: "La Contraseña no coincide")
            return false
        }
        return true
    }
    
    private func errorMaxLength(maxLength: Int) -> String {
        if maxLength == 1{
            return "No ingresar mas de \(maxLength) caracter"
        }else{
            return "No ingresar mas de \(maxLength) caracteres"
        }
    }
    
    private func errorMinLength(minLength: Int) -> String {
        if minLength == 1{
            return "Ingresar mas de \(minLength) caracter"
        }else{
            return "Ingresar mas de \(minLength) caracteres"
        }
    }
    
    private func errorNoText() -> String{
        return "Agrega información a este campo"
    }
    
}
