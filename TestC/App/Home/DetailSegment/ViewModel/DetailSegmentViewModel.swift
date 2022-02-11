//
//  DetailSegmentViewModel.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class DetailSegmentViewModel {

    var responseGetWS:((_ response:ResponseCompany)->())?
    
    // MARK: - callWS
    func callWSTop(){
        
        LoadingSingleton.shareInstance.showLoader(message: "Loading..")
        APIManager.shareInstance.getCompany() { [weak self] (res, err) in
            
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
