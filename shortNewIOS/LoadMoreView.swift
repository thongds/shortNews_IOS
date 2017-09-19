//
//  LoadMoreView.swift
//  shortNewIOS
//
//  Created by SSd on 12/23/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class LoadMoreView: UIView {
    
    var scrollView : UIScrollView?
    let loadMoreHeight : CGFloat = 40
    let indicatorWidth : CGFloat = 30
    var loadmorePresenting : Bool = false
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    required init?(coder aDecoder: NSCoder) {
        scrollView = UIScrollView()
        assert(false,"use init(frame : scrollView) ")
        super.init(coder: aDecoder)
    }
    
    required init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        let frame = CGRect(x: 0, y: scrollView.contentSize.height, width: scrollView.frame.width , height: loadMoreHeight)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.color = UIColor.red
        indicator.backgroundColor = UIColor.red
        indicator.frame = CGRect(x: (frame.width)/2-indicatorWidth/2, y: (frame.height)/2 - indicatorWidth/2, width: indicatorWidth, height: indicatorWidth)
        super.init(frame: frame)
        addSubview(indicator)
        backgroundColor = UIColor.green
    }
    func updateLoadmoreView(showLoadmore : Bool){
         if showLoadmore && !loadmorePresenting {
                loadmorePresenting = showLoadmore
                
                backgroundColor = UIColor.clear
                scrollView?.contentInset.bottom += loadMoreHeight
                
                frame = CGRect(x: 0, y: (scrollView?.contentSize.height)!, width: (scrollView?.frame.width)! , height: loadMoreHeight)
                print(frame)
                indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
                indicator.color = UIColor.white
                indicator.frame = CGRect(x: (frame.width)/2-indicatorWidth/2, y: (frame.height)/2 - indicatorWidth/2, width: indicatorWidth, height: indicatorWidth)
                addSubview(indicator)
                scrollView?.insertSubview(self, at: 0)
                
                indicator.startAnimating()
            }
            if(!showLoadmore && loadmorePresenting){
                loadmorePresenting = showLoadmore
                indicator.stopAnimating()
                self.removeFromSuperview()
                scrollView?.contentInset.bottom -= loadMoreHeight
                
            }
        
    }
    

}
