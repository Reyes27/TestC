//
//  FavoriteController.swift
//  TestC
//
//  Created by móviles 2 on 11/02/22.
//

import UIKit

class FavoriteController: UIViewController {
    
    var titleFavoritos = UILabel(text: "Favoritos", font: UIFont.boldSystemFont(ofSize: 24), textColor: .green, textAlignment: .left, numberOfLines: 0)
    
    fileprivate let cellId = "cellId"
    lazy var showsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = .init(top: 2, left: 2, bottom: 5, right: 2)
        cv.register(ShowsCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        return cv
    }()
    
  
    
    var model = [ResponseArray]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        model = FavoriteManager.shared.sortSavedShows()
        
        self.view.addSubview(titleFavoritos)
        titleFavoritos.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0))
        self.view.addSubview(showsCollection)
        showsCollection.anchor(top: titleFavoritos.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        showsCollection.reloadData()
        // Do any additional setup after loading the view.
    }
    

}

//MARK: - Collection

extension FavoriteController: UICollectionViewDataSource {

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        
        let nav = DetailSegmentViewController()
        nav.model = self.model[indexPath.row]
        let navController = UINavigationController(rootViewController: nav)
        self.present(navController, animated: true, completion: nil)
        
    }

}

extension FavoriteController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: (self.showsCollection.frame.width / 2) - 10, height: (self.showsCollection.frame.height / 2) + 40)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 10, left: 0, bottom: 15, right: 0)
}

}

