//
//  GenericResponseGet.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//


import Foundation

class ResponseGeneric: Decodable {
    let total_results: Int?
    let total_pages: Int?
    let sucess: Bool?
    let page: Int?
    let status_message: String?
    let status_code: Int?
    let results:[ResponseArray]?
}

struct ResponseArray: Codable {
    let poster_path: String?
    let popularity: Double?
    let id: Int?
    let backdrop_path: String?
    let vote_average: Double?
    let overview: String?
    let first_air_date: String?
    let original_language: String?
    let vote_count: Int?
    let name: String?
    let original_name: String?
 
}
