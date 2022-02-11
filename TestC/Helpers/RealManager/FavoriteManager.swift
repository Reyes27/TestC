//
//  FavoriteManager.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//
import Foundation
import RealmSwift

enum StateMessages {
    case update
    case create
}

class FavoriteManager: NSObject {
    
    static let shared = FavoriteManager()
    fileprivate let realm = try! Realm()
    
    private var favoriteResult: Results<FavoriteRealModel>?
    
    private func loadFavorite() {
        favoriteResult = realm.objects(FavoriteRealModel.self)
    }
    
    func ifexist(showsSave: ResponseArray){
    
       
        loadFavorite()
        
        let existe = favoriteResult!.count
        
        if(existe == 0){
            saveOrUpdateShows(showsSave: showsSave,  state: .create)
        }else{
            saveOrUpdateShows(showsSave: showsSave,  state: .update)
        }
        
    }
    
    
    func existenFavoritos() -> Results<FavoriteRealModel>?{
        let favoritosEnDB = realm.objects(FavoriteRealModel.self)
        return favoritosEnDB
    }
    
    func deleteUser(id: String) {
        let user = realm.objects(FavoriteRealModel.self).filter("id = '\(id)'")
        
        do{
            try realm.write{
                realm.delete(user)
            }
        }catch{
            print("Ocurrió un error al eliminar el usuario a la Base de datos Realm.")
        }
    }
    
    func saveOrUpdateShows(showsSave: ResponseArray,state:StateMessages) {

        do {
            try realm.write {
                
                switch(state){
                
                case .create:
                    
               
                        let showsModel = FavoriteRealModel()
                        
                        showsModel.original_name = showsSave.original_name ?? ""
                        showsModel.popularity = showsSave.popularity ?? 0.0
                        showsModel.original_language = showsSave.original_language ?? ""
                        showsModel.poster_path = showsSave.poster_path ?? ""
                        showsModel.vote_average = showsSave.vote_average ?? 0.0
                        showsModel.vote_count = showsSave.vote_count ?? 0
                        showsModel.name = showsSave.name ?? ""
                        showsModel.overview = showsSave.overview ?? ""
                        showsModel.first_air_date = showsSave.first_air_date ?? ""
                        showsModel.id = showsSave.id ?? 0
                        showsModel.backdrop_path = showsSave.backdrop_path ?? ""
             
                        
                        realm.add(showsModel)
                    
                    
              
                    break
                case .update:
                    let user = realm.objects(FavoriteRealModel.self).filter("id = \(showsSave.id ?? 0)")
                    
                    if user.count == 0 {
                        let showsModel = FavoriteRealModel()
                        showsModel.original_name = showsSave.original_name ?? ""
                        showsModel.popularity = showsSave.popularity ?? 0.0
                        showsModel.original_language = showsSave.original_language ?? ""
                        showsModel.poster_path = showsSave.poster_path ?? ""
                        showsModel.vote_average = showsSave.vote_average ?? 0.0
                        showsModel.vote_count = showsSave.vote_count ?? 0
                        showsModel.name = showsSave.name ?? ""
                        showsModel.overview = showsSave.overview ?? ""
                        showsModel.first_air_date = showsSave.first_air_date ?? ""
                        showsModel.id = showsSave.id ?? 0
                        showsModel.backdrop_path = showsSave.backdrop_path ?? ""
                        
                   
                        
                        realm.add(showsModel)
                    }
                      
       
                
                    break
                }
                
              //  print(Realm.Configuration.defaultConfiguration.fileURL)
                
            }
        } catch {
            print("Error saving lote \(error)")
        }
    }
    
    func sortSavedShows() -> [ResponseArray]{
        loadFavorite()
       
       let Shows = favoriteResult
       var ShowsArreglo = [ResponseArray]()

       
        Shows?.forEach({ usuario in
            
            ShowsArreglo.append(ResponseArray(poster_path: usuario.poster_path, popularity:usuario.popularity, id: usuario.id, backdrop_path: usuario.backdrop_path, vote_average: usuario.vote_average, overview: usuario.overview, first_air_date: usuario.first_air_date, original_language: usuario.original_language, vote_count: usuario.vote_count, name: usuario.name, original_name: usuario.original_name))
         
       })
        
       return ShowsArreglo
               
   }

}
