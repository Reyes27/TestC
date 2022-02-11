//
//  LoginViewModel.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class LoginViewModel {
    
    var responseCloseViewModel: (()->())?
    var responseGetWS:((_ response:String, _ responseCode:Int)->())?
    
    // MARK: - callWS
    func callWS(userName:String,password:String){
        
       // DispatchQueue.main.async {
          LoadingSingleton.shareInstance.showLoader(message: "Loading..")
       // }
        APIManager.shareInstance.getToken() { [weak self] (res, err) in
            
            if let err = err {
                print("error al recuperar los mensajes \( err)")
               // DispatchQueue.main.async {
                    LoadingSingleton.shareInstance.dissmissLoader()
                //}
            }
            
            guard let res = res else { return }
            
            //DispatchQueue.main.async {
                if res.success == true {
                    let body = ["username":userName,"password":password,"request_token":res.request_token]
                    
                    APIManager.shareInstance.getSessionLogin(jsonData:body as Dictionary<String, Any>) { [weak self] (res, err) in
                        if let err = err {
                            print("error al recuperar los mensajes \( err)")
                         //   DispatchQueue.main.async {
                                LoadingSingleton.shareInstance.dissmissLoader()
                           // }
                        }
                        
                        guard let res = res else { return }
                        LoadingSingleton.shareInstance.dissmissLoader()
                        if res.success == true {
                            UserDefaults.standard.set(userName, forKey: "UserName")
                            self?.responseGetWS?("\(res.success ?? false)",1)
                        }else{
                            self?.responseGetWS?(res.status_message ?? "",res.status_code ?? 400)
                        }
                    }
                
                }else{
                    LoadingSingleton.shareInstance.dissmissLoader()
                    self?.responseGetWS?(res.status_message ?? "",res.status_code ?? 400)
                }
                
          //  }
            
        }
    }

}
