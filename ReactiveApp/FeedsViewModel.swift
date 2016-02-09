//
//  FriendListViewModel.swift
//  ReactiveApp
//
//  Created by SVYAT on 08.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import RxSwift
import RxCocoa

class FeedsViewModel {
    
    let feedsObservable: Observable<[Feed]>
    let clickObservable: Observable<GetFeedInfoResponse>
    
    // If some process in progress
    let indicator: Observable<Bool>
    
    init(input: (
        UITableView
        ),
        dependency: (
        API: APIManager,
        wireframe: Wireframe
        )
        ) {
            let API = dependency.API
            let wireframe = dependency.wireframe
            
            let indicator = ViewIndicator()
            self.indicator = indicator.asObservable()
            
            feedsObservable = API.getFeeds()
                .trackView(indicator)
                .map { getFeedResponse in
                    return getFeedResponse.data
                }
                .catchError { error in
                    return wireframe.promptFor(String(error), cancelAction: "OK", actions: [])
                        .map { _ in
                            return error
                        }
                        .flatMap { error in
                            return Observable.error(error)
                    }
                }
                .shareReplay(1)
            
            clickObservable = input
                .rx_modelSelected(Feed)
                .flatMap { feed  in
                    return API.getFeedInfo(feed.id)
                        .trackView(indicator)
                }
                .catchError { error in
                    return wireframe.promptFor(String(error), cancelAction: "OK", actions: [])
                        .map { _ in
                            return error
                        }
                        .flatMap { error in
                            return Observable.error(error)
                    }
                }
                // If error when click uitableview - set retry() if you want to click cell again
                .retry()
                .shareReplay(1)
    }
}