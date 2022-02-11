//
//  HomeViewController.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var NewCustomNavigationBar = UIView()
    let moreButtons = UIButton(image: UIImage(named: "menu")!, tintColor: .white, target: self, action: #selector(moreButtonTapped))
    let titleLabel = UILabel(text: "TV Shows", font: UIFont.boldSystemFont(ofSize: 24), textColor: .label)
    var imgRating = UIImageView(image: UIImage(named: "rating"), contentMode: .center)
    var genericV = GenericViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
       
        // Do any additional setup after loading the view.
    }
    
    // MARK: - setUp
    func setUp(){
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(NewCustomNavigationBar)
        NewCustomNavigationBar.layer.shadowOpacity = 0.2
        NewCustomNavigationBar.layer.shadowColor = UIColor.black.cgColor
        NewCustomNavigationBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        NewCustomNavigationBar.backgroundColor = .secondarySystemBackground
        
        NewCustomNavigationBar.addSubview(moreButtons)
        NewCustomNavigationBar.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        
        NewCustomNavigationBar.addSubview(imgRating)
        imgRating.anchor(top: nil, leading: nil, bottom: nil, trailing: moreButtons.leadingAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 10), size: CGSize(width: 40, height: 40))
        imgRating.centerYTo(moreButtons.centerYAnchor)
        
        let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imgRating.addGestureRecognizer(tapGesture)
        imgRating.isUserInteractionEnabled = true
        
        
        NewCustomNavigationBar.withHeight(120)
        moreButtons.anchor(top: NewCustomNavigationBar.topAnchor, leading: nil, bottom: nil, trailing: NewCustomNavigationBar.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 10), size: CGSize(width: 40, height: 40))
        
        NewCustomNavigationBar.addSubview(titleLabel)
        titleLabel.centerInSuperview()
        
        addControl()
    }
    
    func addControl()  {
            let items = ["Popular", "Top Rated", "On TV", "Airing Today"]
            let segmentedControl = UISegmentedControl(items: items)
            segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
            segmentedControl.selectedSegmentIndex = 0
            view.addSubview(segmentedControl)
        
           segmentedControl.anchor(top: NewCustomNavigationBar.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        
        
          view.addSubview(genericV.view)
          genericV.view.anchor(top: segmentedControl.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0))
        
        genericV.optionsWS(id: 0)
        
        }

        @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                genericV.optionsWS(id: 0)
                break // Uno
            case 1:
                genericV.optionsWS(id: 1)
                break // Dos
            case 2:
                genericV.optionsWS(id: 2)
                break // Tres
            case 3:
                genericV.optionsWS(id: 3)
                break // Tres
            default:
                break
            }
        }

    @objc func favoriteTapped(_ sender: UITapGestureRecognizer) {
        self.present(FavoriteController(), animated: false, completion: nil)
     
    }
    
    
    // MARK: - Selectores
    @objc fileprivate func moreButtonTapped (){
        let alert = UIAlertController(title: "What do you want to do ?", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        let okAction = UIAlertAction(title: "View profile", style: .default) { (UIAlertAction) in
            let nav = ProfileViewController()
            let navController = UINavigationController(rootViewController: nav)
            self.present(navController, animated: true, completion: nil)
        }
        let okLogOut = UIAlertAction(title: "Log out", style: .destructive) { (UIAlertAction) in
            UserDefaults.standard.removeObject(forKey: "UserName")
            self.navigationController?.pushViewController(LaunchScreenController(), animated: false)
        }
        
        let okCancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
         
        }
        
        alert.addAction(okAction)
        alert.addAction(okLogOut)
        alert.addAction(okCancel)
        self.present(alert, animated: true, completion: nil)
    }

}
