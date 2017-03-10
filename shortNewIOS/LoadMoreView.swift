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
    
    required init?(coder aDecoder: NSCoder) {
        scrollView = UIScrollView()
        assert(false,"use init(frame : scrollView) ")
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init(frame: frame)
        backgroundColor = UIColor.green
//        let sceneView = UIView(frame: CGRect(x: 0, y: frame.height-sceneHeight, width: frame.width, height: sceneHeight))
//        addSubview(sceneView)
//        let indicatorWidth : CGFloat = 40
//        indicator.frame = CGRect(x: sceneView.frame.width/2 - indicatorWidth/2, y: sceneView.frame.height/2 - indicatorWidth/2, width: indicatorWidth, height: indicatorWidth)
//        sceneView.addSubview(indicator)
//        updateBackgroundColor()
    }
    

}
