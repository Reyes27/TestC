//
//  ShowsCollectionViewCell.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import LBTATools

class ShowsCollectionViewCell: UICollectionViewCell {
    var imgView = UIImageView()
    var img = UIImageView(image: nil, contentMode: .scaleAspectFit)
    var imgRating = UIImageView(image: UIImage(named: "rating"), contentMode: .center)
    var rating = UILabel()
    var name = UILabel()
    var overview = UILabel()
    
    var dateN = UILabel()
    
    var dt = String() {
        didSet{
            if let date = DateFormatter.dateFormatter.date(from: dt) {
                dateN.text = DateFormatter.dayMonthNameYearFormatter.string(from: date)
            }
        }
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        backgroundColor = .darkGray
        
        addSubview(imgView)
        imgView.addSubview(img)
        addSubview(imgRating)
        addSubview(rating)
        addSubview(name)
        addSubview(overview)
        addSubview(dateN)
        

        
        imgView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        imgView.withHeight(220)
        imgView.withWidth((UIScreen.main.bounds.width / 2 ) - 20)
        
        img.anchor(top: imgView.topAnchor, leading: imgView.leadingAnchor, bottom: imgView.bottomAnchor, trailing: imgView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        img.withWidth((UIScreen.main.bounds.width / 2 ) - 20)
        img.contentMode = .scaleToFill
        
        name.anchor(top: imgView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
        name.numberOfLines = 0
        name.textColor = .green
        
        rating.anchor(top: name.bottomAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding:  UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        
        dateN.anchor(top: name.bottomAnchor, leading: self.leadingAnchor, bottom: nil , trailing: nil, padding:  UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        
        imgRating.anchor(top: name.bottomAnchor, leading: nil, bottom: nil, trailing: rating.leadingAnchor, padding: UIEdgeInsets(top:0, left: 5, bottom: 5, right: 5), size: CGSize(width: 30, height: 30))
        imgRating.image?.withTintColor(.green, renderingMode: .alwaysTemplate)
        
        
        overview.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 2, right: 5))
        overview.numberOfLines = 4
        overview.textColor = .white
        overview.withHeight(100)
        
        
        dateN.textColor = .green
        rating.textColor = .green
        
        
        imgView.layer.cornerRadius = 15
        imgView.layer.shadowColor = UIColor.black.cgColor
        imgView.layer.shadowOffset = .zero
        imgView.layer.shadowRadius = 10
        imgView.layer.shadowOpacity = 1
        imgView.layer.masksToBounds = false
        imgView.clipsToBounds = true
        imgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.masksToBounds = true

        
        self.layer.cornerRadius = 20
       
    }
    
}
