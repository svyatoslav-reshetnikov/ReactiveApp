//
//  IdName.swift
//  ReactiveApp
//
//  Created by SVYAT on 09.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import ObjectMapper

class IdName: Mappable {
    
    var id: String!
    var name: String!
    
    required init?(_ map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
}
