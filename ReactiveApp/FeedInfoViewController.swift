//
//  FeedInfoViewController.swift
//  ReactiveApp
//
//  Created by SVYAT on 09.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import UIKit

class FeedInfoViewController: UIViewController {
    
    @IBOutlet weak var feedTextView: UITextView!
    var feedInfo: GetFeedInfoResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var feedDetail = "From: " + feedInfo.from.name
        
        if feedInfo.to.count > 0 {
            feedDetail += "\nTo: "
            for to in feedInfo.to {
                feedDetail += to.name + "\n"
            }
        }
        
        if let date = feedInfo.createdTime {
            feedDetail += "\nDate: " + NSDate().convertFacebookTime(date)
        }
        
        if let story = feedInfo.story {
            feedDetail += "\nStory: " + story
        }
        
        if let message = feedInfo.message {
            feedDetail += "\nMessage: " + message
        }
        
        if let name = feedInfo.name {
            feedDetail += "\nName: " + name
        }
        
        if let type = feedInfo.type {
            feedDetail += "\nType: " + type
        }
        
        if let updatedTime = feedInfo.updatedTime {
            feedDetail += "\nupdatedTime: " + NSDate().convertFacebookTime(updatedTime)
        }
        
        feedTextView.text = feedDetail
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

