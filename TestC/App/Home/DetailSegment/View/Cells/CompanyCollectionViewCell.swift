//
//  CompanyCollectionViewCell.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    var img = UIImageView(image: nil, contentMode: .scaleToFill)
    
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
        addSubview(img)
        img.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        self.layer.cornerRadius = 20
       
    }
    
}
