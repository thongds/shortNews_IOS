//
//  RefreshView.swift
//  shortNewIOS
//
//  Created by SSd on 12/23/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

protocol RefreshDelegate {
    func refreshViewDidRefresh(refreshView : RefreshView)
}

private let sceneHeight : CGFloat = 30
class RefreshView: UIView {

    private unowned  var scrollView : UIScrollView
    var progressPercentage : CGFloat = 0
    var delegate : RefreshDelegate?
    var isRefreshing : Bool = false
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    required init?(coder aDecoder: NSCoder) {
        scrollView = UIScrollView()
        assert(false,"use init(frame : scrollView) ")
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init(frame: frame)
        let sceneView = UIView(frame: CGRect(x: 0, y: frame.height-sceneHeight, width: frame.width, height: sceneHeight))
        addSubview(sceneView)
        let indicatorWidth : CGFloat = 40
        indicator.frame = CGRect(x: sceneView.frame.width/2 - indicatorWidth/2, y: sceneView.frame.height/2 - indicatorWidth/2, width: indicatorWidth, height: indicatorWidth)
        indicator.color = UIColor.white
        sceneView.addSubview(indicator)
        updateBackgroundColor()
    }
    
    func updateBackgroundColor(){
        let value = progressPercentage * 0.7 + 0.2
        backgroundColor = UIColor(red: value, green: value, blue: value, alpha: 1.0)
        backgroundColor = UIColor.clear
    }
    
    func beginRefreshing(){
        isRefreshing = true
        if !indicator.isAnimating{
            indicator.startAnimating()
            
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: { 
            ()-> Void in
            self.scrollView.contentInset.top += sceneHeight
        }, completion: nil)
        
    }
    func endRefreshing(){
        isRefreshing = true
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            ()-> Void in
            self.scrollView.contentInset.top -= sceneHeight
        }, completion: {(_) -> Void in
            self.isRefreshing = false
            self.indicator.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
        
    }
}
extension RefreshView : UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && progressPercentage == 1{
            beginRefreshing()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            //targetContentOffset.pointee.y = -scrollView.contentInset.top
            delegate?.refreshViewDidRefresh(refreshView: self)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isRefreshing {
            return
        }
        if -(scrollView.contentOffset.y) >= sceneHeight {
            if !indicator.isAnimating {
                indicator.startAnimating()
            }
        }
        let refreshVisibleHeight = max(0,-(scrollView.contentOffset.y + scrollView.contentInset.top))
        progressPercentage = min(1,refreshVisibleHeight/sceneHeight)
        updateBackgroundColor()
    }
}
