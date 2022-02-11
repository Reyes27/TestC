//
//  ResponseCompany.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import Foundation

class ResponseCompany: Decodable {
    let sucess: Bool?
    let page: Int?
    let status_message: String?
    let status_code: Int?
    let logos:[ResponseCompanyLogos]?
}

class ResponseCompanyLogos: Decodable {
    let file_path: String?
    let file_type: String?
}

