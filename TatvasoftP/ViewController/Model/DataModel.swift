//
//  UserModel.swift
//  CaperMintP
//
//  Created by Jaydip's Mackbook on 16/09/20.
//  Copyright © 2020 Jaydip's Macbook. All rights reserved.
//

import Foundation


class DataModel: NSObject {
    
    var id                  : Int?
    var strTitle            : String?
    var strDate             : String?
    var strOverview         : String?
    var strImage            : String?
    
    init(_ dict: [String: Any]) {
        
        id                      = dict["id"] as? Int ?? 0
        strTitle                = dict["title"] as? String ?? ""
        strDate                 = dict["release_date"] as? String ?? ""
        strOverview             = dict["overview"] as? String ?? ""
        strImage                = dict["poster_path"] as? String ?? ""
        
    }
}

class MovieData: NSObject {
    
    var id                  : Int?
    var production_companies  : [genres]?//genres?
    var generc                : [genres]?//genres?
    var production_countries  : [production_companies]?//production_companies?
    var spoken_languages      : [production_companies]?//production_companies?
    var realesedate           : String?
    var overView              : String?
    var tagline               : String?
    var revenue               : Int?
    var budget               : Int?
    var title               : String?
    var backBanner          : String?
    var poster_path          : String?
    
    init(_ dict: [String: Any]) {
        
        id                      = dict["id"] as? Int ?? 0
        production_companies    = dict["production_companies"] as? [genres] ?? []
        production_countries    = dict["production_countries"] as? [production_companies] ?? []
        spoken_languages        = dict["spoken_languages"] as? [production_companies]
        generc                  = dict["genres "] as? [genres] ?? []
        realesedate             = dict["realesedate"] as? String ?? ""
        overView                = dict["overview"] as? String ?? ""
        tagline                 = dict["tagline"] as? String ?? ""
        revenue                 = dict["revenue"] as? Int ?? 0
        budget                 = dict["budget"] as? Int ?? 0
        title                 = dict["title"] as? String ?? ""
        backBanner                 = dict["backdrop_path"] as? String ?? ""
        poster_path                 = dict["poster_path"] as? String ?? ""
        
    }
}

class production_companies: NSObject {
    
    var iso_3166_1          : String?
    var name                : String?
   
    
    
    init(_ dict: [String: Any]) {
        
        iso_3166_1                      = dict["iso_3166_1"] as? String ?? ""
        name                    = dict["name"] as? String ?? ""
        
    }
}
class genres: NSObject {
    
    var id          : String?
    var name                : String?
   
    
    
    init(_ dict: [String: Any]) {
        
        id                      = dict["iso_3166_1"] as? String ?? ""
        name                    = dict["name"] as? String ?? ""
        
    }
}
