//
//  GetFeedsResponse.swift
//  ReactiveApp
//
//  Created by SVYAT on 08.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import ObjectMapper

class GetFeedsResponse: Mappable {
    
    var data = [Feed]()
    var paging: Paging!
    
    required init?(_ map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        paging <- map["paging"]
    }
    
}
