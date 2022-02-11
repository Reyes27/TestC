//
//  APIManager.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit
import Foundation

class APIManager {

    static let shareInstance = APIManager()
//MARK: - API
    
    
    
    func getToken( completion: @escaping(ResponseTokenLogin?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(GlobalConstans.apiKeyV3)"
        genericGet(urlString: urlString, params: nil, completion: completion)
    }
    
    
    func getSessionLogin(jsonData: Dictionary<String, Any>,  completion: @escaping(ResponseTokenLogin?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(GlobalConstans.apiKeyV3)"
        genericPostModel(urlString: urlString, params: jsonData, completion: completion)
    }
    
    
    func getPupularTV( completion: @escaping(ResponseGeneric?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/tv/popular?api_key=\(GlobalConstans.apiKeyV3)=en-US&page=1"
        genericGet(urlString: urlString, params: nil, completion: completion)
    }
    
    func getTopTV( completion: @escaping(ResponseGeneric?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(GlobalConstans.apiKeyV3)&language=en-US&page=1"
        genericGet(urlString: urlString, params: nil, completion: completion)
    }
    
    func getOnTV( completion: @escaping(ResponseGeneric?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(GlobalConstans.apiKeyV3)&language=en-US&page=1"
        genericGet(urlString: urlString, params: nil, completion: completion)
    }
    
    func getAiringTV( completion: @escaping(ResponseGeneric?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/tv/airing_today?api_key=\(GlobalConstans.apiKeyV3)&language=en-US&page=1"
        genericGet(urlString: urlString, params: nil, completion: completion)
    }
    
    func getCompany( completion: @escaping(ResponseCompany?, Error?) -> ()) {
        let urlString  = "https://api.themoviedb.org/3/company/3/images?api_key=\(GlobalConstans.apiKeyV3)&language=en-US&page=1"
        genericGet(urlString: urlString, params: nil, completion: completion)
    }

//MARK: - POST

        private func genericPostModel<T: Decodable>(urlString: String, params: Dictionary<String, Any>?, completion: @escaping(T?, Error?) -> ()) {
                guard let url = URL(string: urlString) else { return }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
               
                if let params = params {
                    guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed) else {
                        return
                    }
                    
                    request.httpBody = httpBody
                }
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
            
           
                
                URLSession.shared.dataTask(with: request) { (data, resp, err) in
                    if let err = err {
                        completion(nil, err)
                        print("Error al obtener:", err)
                        return
                    }
                    
                    guard let data = data else { return }
                    let stringData = String(data: data, encoding: .utf8)
                    print(stringData ?? "")
                    print("===== AQUIIIIIIIIII: \(stringData ?? "")")
                    do {
                        let objects = try JSONDecoder().decode(T.self, from: data)
                        completion(objects, nil)
                    } catch {
                        print("Error al decodificar:", error)
                        completion(nil, error)
                    }
                }.resume()
        }

    //MARK: - GET
        private func genericGet<T: Decodable>(urlString: String, params: [String: String]?, completion: @escaping(T?, Error?) -> ()) {
            
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
            if let params = params {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed) else {
                    return
                }
                request.httpBody = httpBody
            }
            
            URLSession.shared.dataTask(with: request) { (data, resp, err) in
                if let err = err {
                    completion(nil, err)
                    print("Error al obtener:", err)
                    return
                }
                
                guard let data = data else { return }
                let stringData = String(data: data, encoding: .utf8)
                print("Data return: ",stringData)

                do {
                    let objects = try JSONDecoder().decode(T.self, from: data)
                  //  print("Data return: ",objects)
         
                    completion(objects, nil)
                } catch {
                    print("Error al decodificar:", error)
                    completion(nil, error)
                }
            }.resume()
        }

}
