//
//  ViewController.swift
//  ReactiveApp
//
//  Created by Svyatoslav Reshetnikov on 25.01.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class FeedsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var feedsTableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = FeedsViewModel(
            input:feedsTableView,
            dependency: (
                API: APIManager.sharedAPI,
                wireframe: DefaultWireframe.sharedInstance
            )
        )
        
        let progress = MBProgressHUD()
        progress.mode = MBProgressHUDMode.Indeterminate
        progress.labelText = "Загрузка данных..."
        progress.dimBackground = true
        
        viewModel.indicator
            .bindTo(progress.rx_mbprogresshud_animating)
            .addDisposableTo(self.disposeBag)
        
        feedsTableView.rx_setDelegate(self)
        
        viewModel.feedsObservable
            .bindTo(feedsTableView.rx_itemsWithCellFactory) { tableView, row, feed in
                
                let cell = tableView.dequeueReusableCellWithIdentifier("feedTableViewCell") as! FeedTableViewCell
                
                cell.feedCreatedTime.text = NSDate().convertFacebookTime(feed.createdTime)
                
                if let story = feed.story {
                    cell.feedInfo.text = story
                } else if let message = feed.message {
                    cell.feedInfo.text = message
                }
                
                cell.layoutMargins = UIEdgeInsetsZero
            
                return cell
            }
            .addDisposableTo(disposeBag)
        
        viewModel.clickObservable
            .subscribeNext { feed in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let feedInfoViewController = storyboard.instantiateViewControllerWithIdentifier("feedInfoViewController") as! FeedInfoViewController
                feedInfoViewController.feedInfo = feed
                self.navigationController?.pushViewController(feedInfoViewController, animated: true)
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Deselect tableView row after click
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

