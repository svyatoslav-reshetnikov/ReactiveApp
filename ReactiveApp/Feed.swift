//
//  Feed.swift
//  ReactiveApp
//
//  Created by SVYAT on 08.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import ObjectMapper

class Feed: Mappable {
    
    var createdTime: String!
    var id: String!
    var story: String?
    var message: String?
    
    required init?(_ map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        createdTime <- map["created_time"]
        id <- map["id"]
        story <- map["story"]
        message <- map["message"]
    }
    
}
