//
//  GenericViewModel.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class GenericViewModel {
    
    var responseGetWS:((_ response:ResponseGeneric)->())?
    
    // MARK: - callWS
    func callWSTop(){
        
        LoadingSingleton.shareInstance.showLoader(message: "Loading..")
        APIManager.shareInstance.getTopTV() { [weak self] (res, err) in
            
            if let err = err {
                print("error al recuperar los mensajes \( err)")
                    LoadingSingleton.shareInstance.dissmissLoader()
            }
            
            guard let res = res else { return }
            LoadingSingleton.shareInstance.dissmissLoader()
            self?.responseGetWS?(res)
            
            
        }
    }
    
    func callWSOn(){
        
        LoadingSingleton.shareInstance.showLoader(message: "Loading..")
        APIManager.shareInstance.getOnTV() { [weak self] (res, err) in
            
            if let err = err {
                print("error al recuperar los mensajes \( err)")
                    LoadingSingleton.shareInstance.dissmissLoader()
            }
            
            guard let res = res else { return }
            LoadingSingleton.shareInstance.dissmissLoader()
            self?.responseGetWS?(res)
        }
    }
    
    func callWSPopular(){
        
        LoadingSingleton.shareInstance.showLoader(message: "Loading..")
        APIManager.shareInstance.getPupularTV() { [weak self] (res, err) in
            
            if let err = err {
                print("error al recuperar los mensajes \( err)")
                    LoadingSingleton.shareInstance.dissmissLoader()
            }
            
            guard let res = res else { return }
            LoadingSingleton.shareInstance.dissmissLoader()
            self?.responseGetWS?(res)
            
        }
    }
    
    func callWSAir(){
        
        LoadingSingleton.shareInstance.showLoader(message: "Loading..")
        APIManager.shareInstance.getAiringTV() { [weak self] (res, err) in
            
            if let err = err {
                print("error al recuperar los mensajes \( err)")
                    LoadingSingleton.shareInstance.dissmissLoader()
            }
            
            guard let res = res else { return }
            LoadingSingleton.shareInstance.dissmissLoader()
            self?.responseGetWS?(res)
            
        }
    }

}
