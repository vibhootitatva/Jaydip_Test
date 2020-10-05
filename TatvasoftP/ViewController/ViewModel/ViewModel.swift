//
//  UserViewModel.swift
//  CaperMintP
//
//  Created by Jaydip's Mackbook on 16/09/20.
//  Copyright © 2020 Jaydip's Macbook. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    
    //MARK:- Variable
    
    var strApiKey = "14bc774791d9d20b3a138bb6e26e2579"
    var strMoviewListAPI = "https://api.themoviedb.org/3/discover/movie?api_key="
    var strMoviewDataAPI = "https://api.themoviedb.org/3/movie/"
    var strImageBaseUrl = "https://image.tmdb.org/t/p/"//"https://image.tmdb.org/t/p/w185"
    var arrMoviewList = [DataModel]()
    var objMoviewData = MovieData([:])
    
    func getMoviewList(success:@escaping (_ isSuccess:Bool,_ message:String)-> Void){
        let url = "\(strMoviewListAPI)\(strApiKey)"
        
        NetworkManager().APICall(strUrl: url, isLoaderShow: true) { (response) in
            print(response)
            if let arrMovie = (response?["results"]) as? [[String:Any]] {
                for objMoview in arrMovie {
                    self.arrMoviewList.append(DataModel(objMoview))
                }
            }
            success(true,"success")
        }
    }
    func getMoviewData(objId:Int,success:@escaping (_ isSuccess:Bool,_ message:String)-> Void){
        let url = "\(strMoviewDataAPI)\(objId)?api_key=\(strApiKey)"
        
        NetworkManager().APICall(strUrl: url, isLoaderShow: false) { (response) in
            print(response)
            if let dicMovie = response {
                
                self.objMoviewData = MovieData(dicMovie)
                if let arrpCpmpany = dicMovie["production_companies"] as? [[String:Any]]{
                    for obj in arrpCpmpany{
                        self.objMoviewData.production_companies?.append(genres(obj))
                    }
                }
                if let arrGenric = dicMovie["genres"] as? [[String:Any]]{
                    for obj in arrGenric{
                        self.objMoviewData.generc?.append(genres(obj))
                    }
                }
                if let arrSpokenL = dicMovie["spoken_languages"] as? [[String:Any]]{
                    for obj in arrSpokenL{
                        self.objMoviewData.spoken_languages?.append(production_companies(obj))
                    }
                }
                if let arrpCountry = dicMovie["production_countries"] as? [[String:Any]]{
                    for obj in arrpCountry{
                        self.objMoviewData.production_countries?.append(production_companies(obj))
                    }
                }
            }
            success(true,"success")
        }
    }
}
