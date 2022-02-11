//
//  LaunchScreenController.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if  UserDefaults.standard.string(forKey: "UserName") != nil {
            navigationController?.pushViewController(HomeViewController(), animated: false)
        }else{
            navigationController?.pushViewController(LoginViewController(), animated: false)
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
