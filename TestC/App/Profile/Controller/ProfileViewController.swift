//
//  ProfileViewController.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import LBTATools

class ProfileViewController: UIViewController {
    
    fileprivate let cellId = "cellId"
    lazy var showsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(ShowsCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        return cv
    }()
    
    var titleProfile = UILabel(text: "Profile", font: UIFont.boldSystemFont(ofSize: 24), textColor: .green, textAlignment: .left, numberOfLines: 0)
    var titleProfileCollection = UILabel(text: "Favorite Shows", font: UIFont.boldSystemFont(ofSize: 24), textColor: .green, textAlignment: .left, numberOfLines: 0)
    
    var titleProfileUsername = UILabel(text: "@\(UserDefaults.standard.string(forKey: "UserName") ?? "")", font: UIFont.boldSystemFont(ofSize: 18), textColor: .green, textAlignment: .center, numberOfLines: 0)
    var img = UIImageView(image: UIImage(named: "profileImage"), contentMode: .scaleToFill)
    
    var genericViewModel: GenericViewModel = {
        return GenericViewModel()
    }()
    
    var model = [ResponseArray]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setUp()
        initVM()
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation
    
    // MARK: - initVM
    internal func initVM(){
        genericViewModel.responseGetWS = {(response) in
            self.model = response.results ?? [ResponseArray]()
            DispatchQueue.main.async {
                if response.sucess == false {
                    
                    let alert = UIAlertController(title: "Mensaje", message: "Intente más tarde.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "Entiendo", style: .default) { (UIAlertAction) in
                     
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }else{
                  self.showsCollection.reloadData()
                }
            }
        }
    }

    
    
    func setUp(){
        self.view.addSubview(titleProfile)
        self.view.addSubview(titleProfileCollection)
        self.view.addSubview(titleProfileUsername)
        self.view.addSubview(showsCollection)
        self.view.addSubview(img)
        
        titleProfile.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        
        img.anchor(top: titleProfile.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0))
        img.layer.cornerRadius = 160 / 2
        img.clipsToBounds = true
        img.withSize(CGSize(width: 160, height: 160))
     
        titleProfileUsername.anchor(top: nil, leading: img.trailingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        titleProfileUsername.centerYTo(img.centerYAnchor)
        
        titleProfileCollection.anchor(top: img.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0))
        showsCollection.anchor(top: titleProfileCollection.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 60, right: 0))
        //showsCollection.withHeight(270)
        
        genericViewModel.callWSTop()
    }

}

//MARK: - Collection

extension ProfileViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowsCollectionViewCell
    
    cell.dt = self.model[indexPath.row].first_air_date ?? ""
    cell.name.text = self.model[indexPath.row].name
    cell.overview.text = self.model[indexPath.row].overview
    cell.rating.text = "\(self.model[indexPath.row].vote_average ?? 0.0)"
    
    cell.img.sd_setImage(with:  URL(string: "http://image.tmdb.org/t/p/w500\(self.model[indexPath.row].poster_path!)")) { [weak self] (image, error, cacheType, url) in
        if error != nil {

        }
    }

    return cell
}


}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    .init(width: (self.showsCollection.frame.width / 2) - 10, height: self.showsCollection.frame.height )
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 0, bottom: 0, right: 0)
}

}
