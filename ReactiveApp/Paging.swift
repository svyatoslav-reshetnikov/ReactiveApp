//
//  Paging.swift
//  ReactiveApp
//
//  Created by SVYAT on 08.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import ObjectMapper

class Paging: Mappable {
    
    var next: String!
    var previous: String!
    
    required init?(_ map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        next <- map["next"]
        previous <- map["previous"]
    }
    
}
