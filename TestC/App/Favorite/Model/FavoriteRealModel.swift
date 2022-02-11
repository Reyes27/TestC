//
//  FavoriteRealModel.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import Foundation
import RealmSwift


class FavoriteRealModel: Object {
    
    @objc dynamic var poster_path: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var id: Int = 0
    @objc dynamic var backdrop_path: String = ""
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var overview: String = ""
    @objc dynamic var first_air_date: String = ""
    @objc dynamic var original_language: String = ""
    @objc dynamic var vote_count: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var original_name: String = ""
    

}
