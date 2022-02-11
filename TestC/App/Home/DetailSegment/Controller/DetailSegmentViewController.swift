//
//  DetailSegmentViewController.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import SDWebImage

class DetailSegmentViewController: UIViewController {
    
    var img = UIImageView()
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    var label5 = UILabel()
    var label6 = UILabel()
    var label7 = UILabel()

    var model : ResponseArray?
    var model2:[ResponseCompanyLogos]?
    
    var imgRating = UIImageView(image: UIImage(named: "rating"), contentMode: .center)
    
    fileprivate let cellId = "cellId"
    lazy var showsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = .init(top: 2, left: 2, bottom: 5, right: 2)
        cv.register(CompanyCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        return cv
    }()
    
    var detailSegmentViewModel: DetailSegmentViewModel = {
        return DetailSegmentViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUp()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - SETUP
    
    func setUp(){
        self.view.addSubview(imgRating)
        self.view.addSubview(img)
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
        self.view.addSubview(label5)
        self.view.addSubview(label6)
        self.view.addSubview(label7)
        self.view.addSubview(showsCollection)
        
        
        
        imgRating.anchor(top: self.view.topAnchor, leading: nil, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
        imgRating.contentMode = .scaleToFill
        imgRating.withWidth(40)
        imgRating.withHeight(40)
        
        img.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        img.withWidth(180)
        img.withHeight(240)
        
        label1.anchor(top: imgRating.bottomAnchor, leading: img.trailingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        label1.numberOfLines = 2
        label1.textColor = .green
        label2.anchor(top: label1.bottomAnchor, leading: img.trailingAnchor, bottom: nil, trailing:  self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        label2.numberOfLines = 10
        label2.withHeight(80)
        label2.textColor = .green
        
        label3.anchor(top: img.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing:  self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        label3.textColor = .white
        
        label4.anchor(top: label3.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing:  self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        label4.textColor = .white
        
        label5.anchor(top: label4.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing:  self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        label5.textColor = .white
        
        label6.anchor(top: label5.bottomAnchor, leading: self.view.leadingAnchor, bottom:nil, trailing:  self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        label6.textColor = .white
        
        label7.anchor(top: label6.bottomAnchor, leading: self.view.leadingAnchor, bottom:nil, trailing:  self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        label7.textColor = .white
        label7.numberOfLines = 0
        showsCollection.withHeight(170)
        showsCollection.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        detailSegmentViewModel.callWSTop()
        
        img.sd_setImage(with:  URL(string: "http://image.tmdb.org/t/p/w500\(self.model?.poster_path! ?? "")")) { [weak self] (image, error, cacheType, url) in
            if error != nil {

            }
        }
        
        label1.text = self.model?.name
        label2.text = self.model?.overview
        label3.text = "Original language : \(self.model?.original_language ?? "")"
        label4.text = "Popularity : \(self.model?.popularity ?? 0.0)"
        label5.text = "Vote : \(self.model?.vote_average ?? 0.0) "
        label6.text = "Original name : \(self.model?.original_name ?? "")"
        label7.text = "Nota: La mayoria de las compañias vienen en formato .svg por eso no se muestran para que tuviera algo el collection le puse la llave de backdrop_path"
        
        
        let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imgRating.addGestureRecognizer(tapGesture)
        imgRating.isUserInteractionEnabled = true
    }
    
    @objc func favoriteTapped(_ sender: UITapGestureRecognizer) {
        LoadingSingleton.shareInstance.showLoader(message: "Loading..")
        FavoriteManager.shared.ifexist(showsSave: model!)
        LoadingSingleton.shareInstance.dissmissLoader()
    }
    
    
    // MARK: - initVM
    internal func initVM(){
        detailSegmentViewModel.responseGetWS = {(response) in
            self.model2 = response.logos ?? [ResponseCompanyLogos]()
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


}

//MARK: - Collection

extension DetailSegmentViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10 //self.model2?.count ?? 0
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CompanyCollectionViewCell
    
    cell.img.sd_setImage(with:  URL(string: "http://image.tmdb.org/t/p/w500\(self.model?.backdrop_path ?? "")")) { [weak self] (image, error, cacheType, url) in
        if error != nil {

        }
    }

    return cell
}


}

extension DetailSegmentViewController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: 150, height: 150)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 10, left: 10, bottom: 15, right: 10)
}

}
