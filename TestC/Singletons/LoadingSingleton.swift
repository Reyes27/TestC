//
//  LoadingSingleton.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import SVProgressHUD

class LoadingSingleton: NSObject {
    static let shareInstance = LoadingSingleton()
    
    func showLoader(message:String)-> Void{
       // UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.show(withStatus: message)
    }
    
    func dissmissLoader()->Void{
       // UIApplication.shared.endIgnoringInteractionEvents()
        SVProgressHUD.dismiss()
    }
}
