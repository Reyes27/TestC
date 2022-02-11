//
//  GenericModelGetResponse.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import Foundation



class ResponseTokenLogin: Decodable {
    let success: Bool?
    let expires_at: String?
    let request_token: String?
    let status_message: String?
    let status_code: Int?
}
