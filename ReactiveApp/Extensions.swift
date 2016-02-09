//
//  Extensions.swift
//  ReactiveApp
//
//  Created by SVYAT on 08.02.16.
//  Copyright © 2016 Svyatoslav Reshetnikov. All rights reserved.
//

import RxSwift
import RxCocoa
import MBProgressHUD

extension MBProgressHUD {
    
    /**
     Bindable sink for MBProgressHUD show/hide methods.
     */
    public var rx_mbprogresshud_animating: AnyObserver<Bool> {
        return AnyObserver {event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch (event) {
            case .Next(let value):
                if value {
                    let loadingNotification = MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow?.subviews.last, animated: true)
                    loadingNotification.mode = self.mode
                    loadingNotification.labelText = self.labelText
                    loadingNotification.dimBackground = self.dimBackground
                } else {
                    MBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow?.subviews.last, animated: true)
                }
            case .Error(let error):
                let error = "Binding error to UI: \(error)"
                #if DEBUG
                    rxFatalError(error)
                #else
                    print(error)
                #endif
            case .Completed:
                break
            }
        }
    }
}

extension NSDate {
    
    func convertFacebookTime (facebookTime: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        let date = dateFormatter.dateFromString(facebookTime)
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter.stringFromDate(date!)
    }
    
}