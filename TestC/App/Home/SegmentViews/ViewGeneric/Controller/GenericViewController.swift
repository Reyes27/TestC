//
//  GenericViewController.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import SDWebImage

class GenericViewController: UIViewController,UIGestureRecognizerDelegate
{
    
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
    
    var genericViewModel: GenericViewModel = {
        return GenericViewModel()
    }()
    
    var model = [ResponseArray]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initVM()
        self.view.addSubview(showsCollection)
        showsCollection.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        // Do any additional setup after loading the view.
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
           longPressGesture.minimumPressDuration = 1.0 // 1 second press
           longPressGesture.allowableMovement = 15 // 15 points
           longPressGesture.delegate = self
           self.showsCollection.addGestureRecognizer(longPressGesture)
    }
    
    func optionsWS(id:Int){
        switch id {
        case 0:
            genericViewModel.callWSTop()
        case 1:
            genericViewModel.callWSPopular()
        case 2:
            genericViewModel.callWSOn()
        case 3:
            genericViewModel.callWSAir()
        default:
            break
        }
    }
    
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
    
    //MARK:- Long Press Gesture
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {

        if sender.state == UIGestureRecognizer.State.ended {
            return
        }
        else if sender.state == UIGestureRecognizer.State.began
        {
            let p = sender.location(in: self.showsCollection)
            let indexPath = self.showsCollection.indexPathForItem(at: p)

            if let index = indexPath {
                var cell = self.showsCollection.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                
     
                FavoriteManager.shared.ifexist(showsSave: model[index.row])
                
                let alert = UIAlertController(title: "Message", message: "Successfully added to favorites", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "Okey", style: .default) { (UIAlertAction) in
                 
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)

                
                print(index.row)
                print("longpressed Tag: \(index.row)")
            } else {
                print("Could not find index path")
            }
        }
    }

}

//MARK: - Collection

extension GenericViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowsCollectionViewCell
    
    cell.dt = self.model[indexPath.row].first_air_date ?? ""
    cell.name.text = self.model[indexPath.row].name
    cell.overview.text = self.model[indexPath.row].overview
    cell.rating.text = "\(self.model[indexPath.row].vote_average ?? 0.0)"
    
    cell.img.sd_setImage(with:  URL(string: "http://image.tmdb.org/t/p/w500\(self.model[indexPath.row].poster_path ?? "")")) { [weak self] (image, error, cacheType, url) in
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

extension GenericViewController: UICollectionViewDelegateFlowLayout {

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
