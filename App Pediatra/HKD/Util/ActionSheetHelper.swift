//
//  ActionSheetHelper.swift
//  HKD
//
//  Created by Macbook Air on 4/19/19.
//  Copyright © 2019 revoktek. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import NotificationBannerSwift

class ActionSheetHelper {
    
    
//    static func showActionBaby(viewController: UIViewController){
//
////        if ConfigureDefaults().getIdBaby() == -1{
////            let babys: [Dependiente] = DaoDependiente().getAllByUsuario(usuario: ConfigureDefaults().getIdUser())
////            if  babys.count > 0{
////                let alert = UIAlertController(title: "Selecciona un bebé", message: "De quien quieres ver datos", preferredStyle: .actionSheet)
////                for baby in babys{
////                    alert.addAction(UIAlertAction(title: baby.nombre! + " " + baby.apellidos! , style: .default, handler: { action in
////                        ConfigureDefaults().setIdBaby(idBaby: baby.id!)
////                    }))
////                }
////                viewController.present(alert, animated: true)
////            }else{
////                let alert = UIAlertController(title: "Agrega un bebé primero", message: "Debes agregar un bebé para usar las funcionalidades completamete", preferredStyle: .alert)
////                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
////                viewController.present(alert, animated: true)
////            }
////        }
//    }
//
//    static func selectBaby(viewController: UIViewController){
//        let myGroup = DispatchGroup()
//        //var bebeList: [JSON] = []
//
//        myGroup.enter()
//        DaoDependiente().obtainList() { bebeJson, success in
//
////            let babys: [Dependiente] = [baby1,baby2]
//            //DaoDependiente().getAllByUsuario(usuario: ConfigureDefaults().getIdUser())
//            if  bebeJson.count > 0 {
//                let alert = UIAlertController(title: "Seleccione su bebé...", message: "", preferredStyle: .actionSheet)
//                for baby in bebeJson {
//                    alert.addAction(UIAlertAction(title: baby["nombreCompleto"].stringValue, style: .default, handler: { action in
//                        ConfigureDefaults().setIdBaby(idBaby: baby["id"].intValue)
//                        ConfigureDefaults().setBabyNac(nac: baby["fecNacimiento"].stringValue)
//                        ConfigureDefaults().setBabyGenero(nac: baby["sexo"].intValue)
//                    }))
//                }
//                viewController.present(alert, animated: true)
//            }
//            else{
//                let banner = StatusBarNotificationBanner(title: "Aún no tiene bebés registrados.", style: .danger)
//                banner.show()
//            }
//            myGroup.leave()
//        }
//
//        myGroup.notify(queue: .main) {
//
//        }
//
////        if ConfigureDefaults().getIdBaby() != -1{
////
////        }
    //}
}
