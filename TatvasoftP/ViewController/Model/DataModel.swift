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
    var strFname            : String?
    
    init(_ dict: [String: Any]) {
        
        id                      = dict["id"] as? Int ?? 0
        strFname                = dict["first_name"] as? String ?? ""
        
    }
}
