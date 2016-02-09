//
//  APIManager.swift
//  ReactiveApp
//
//  Created by SVYAT on 08.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import RxSwift
import RxCocoa
import FBSDKCoreKit
import ObjectMapper

protocol APIProtocol {
    func getFeeds() -> Observable<GetFeedsResponse>
    func getFeedInfo(feedId: String) -> Observable<GetFeedInfoResponse> 
}

class APIManager: APIProtocol {
    
    static let sharedAPI = APIManager()
    
    func getFeeds() -> Observable<GetFeedsResponse> {
        
        return Observable.create { observer in
            let parameters = ["fields": ""]
            let friendsRequest = FBSDKGraphRequest.init(graphPath: "me/feed", parameters: parameters, HTTPMethod: "GET")
            friendsRequest.startWithCompletionHandler { (connection, result, error) -> Void in
                if error != nil {
                    observer.on(.Error(error!))
                } else {
                    let getFeedsResponse = Mapper<GetFeedsResponse>().map(result)!
                    observer.on(.Next(getFeedsResponse))
                    observer.on(.Completed)
                }
            }
            
            return AnonymousDisposable {
                
            }
        }
    }
    
    func getFeedInfo(feedId: String) -> Observable<GetFeedInfoResponse> {
        return Observable.create { observer in
            let parameters = ["fields" : "id,admin_creator,application,call_to_action,caption,created_time,description,feed_targeting,from,icon,is_hidden,is_published,link,message,message_tags,name,object_id,picture,place,privacy,properties,shares,source,status_type,story,story_tags,targeting,to,type,updated_time,with_tags"]
            let friendsRequest = FBSDKGraphRequest.init(graphPath: "" + feedId, parameters: parameters, HTTPMethod: "GET")
            friendsRequest.startWithCompletionHandler { (connection, result, error) -> Void in
                if error != nil {
                    observer.on(.Error(error!))
                } else {
                    print(result)
                    let getFeedInfoResponse = Mapper<GetFeedInfoResponse>().map(result)!
                    observer.on(.Next(getFeedInfoResponse))
                    observer.on(.Completed)
                }
            }
            
            return AnonymousDisposable {
                
            }
        }
    }
}