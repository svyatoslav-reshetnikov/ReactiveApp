//
//  GetFeedInfoResponse.swift
//  ReactiveApp
//
//  Created by SVYAT on 09.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import ObjectMapper

class GetFeedInfoResponse: Mappable {
    
    var createdTime: String!
    var from: IdName!
    var id: String!
    var isHidden: Bool!
    var isPublished: Bool!
    var message: String?
    var name: String?
    var statusType: String?
    var story: String?
    var to = [IdName]()
    var type: String!
    var updatedTime: String!
    
    required init?(_ map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        createdTime <- map["created_time"]
        from <- map["from"]
        id <- map["from"]
        isHidden <- map["is_hidden"]
        isPublished <- map["is_published"]
        message <- map["message"]
        name <- map["name"]
        statusType <- map["status_type"]
        story <- map["story"]
        
        // It necessary that Facebook API have a bad structure
        // buffer%varname% is a temporary variable
        var bufferTo = NSDictionary()
        bufferTo <- map["to"]
        if let bufferData = bufferTo["data"] as? NSArray {
            for bufferDataElement in bufferData {
                let bufferToElement = Mapper<IdName>().map(bufferDataElement)
                to.append(bufferToElement!)
            }
        }
        
        type <- map["type"]
        updatedTime <- map["updated_time"]
    }
    
}
