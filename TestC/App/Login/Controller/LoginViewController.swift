//
//  LoginViewController.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import LBTATools

class LoginViewController: UIViewController {
    
    var email:MDCOutlinedTextField!
    var password:MDCOutlinedTextField!
    
    var singUp = UIButton()
    
    var textLabel = UILabel()
    
    var loginViewModel: LoginViewModel = {
        return LoginViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initVM()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - initVM
    internal func initVM(){
        loginViewModel.responseGetWS = {(response,code) in
            DispatchQueue.main.async {
                if code == 1 {
                    self.navigationController?.pushViewController(HomeViewController(), animated: false)
                }else{
                        self.textLabel.text = response
                    
                    }
            }

            
        }
    }
    

    func setUpView(){
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = true
        
        email = MDCOutlinedTextField()
        email.customPropiertiesControllerOnTextFields(placeholder: "Username",labelTextHelper:"Username")
        email.backgroundColor = .secondarySystemBackground
        
        password = MDCOutlinedTextField()
        password.customPropiertiesControllerOnTextFields(placeholder: "password",labelTextHelper:"password")
        password.backgroundColor = .secondarySystemBackground
        password.isSecureTextEntry = true
    
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(singUp)
        self.view.addSubview(textLabel)
        
        singUp.accessibilityLabel = "Log in"
        singUp.setTitleColor(.white, for: .normal)
        singUp.backgroundColor = .secondarySystemBackground
        singUp.setTitle("Log in", for: .normal)
        
        textLabel.textColor = .orange//UIColor(named: "BackgroundColor")
        textLabel.text = ""
        textLabel.font = UIFont.systemFont(ofSize: 18)
        textLabel.numberOfLines =  2
        

        
        
        email.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: UIEdgeInsets(top: (self.view.frame.height / 2) - 60, left: 20, bottom: 0, right: 20))
        
        password.anchor(top: email.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor,padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))

        
        singUp.anchor(top: password.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing:  self.view.trailingAnchor,padding: UIEdgeInsets(top: 40, left: 40, bottom: 0, right: 40))
        singUp.withHeight(60)
        singUp.layer.cornerRadius = 18
        
        textLabel.anchor(top: singUp.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing:  self.view.trailingAnchor,padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 10))
        
        let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(singUpTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        singUp.addGestureRecognizer(tapGesture)
        singUp.isUserInteractionEnabled = true

    }
    
    @objc func singUpTapped(_ sender: UITapGestureRecognizer) {
        loginViewModel.callWS(userName:self.email.text!,password:self.password.text!)
    }

}
