//
//  ScrollViewIndicator.swift
//  shortNewIOS
//
//  Created by SSd on 12/20/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

protocol ScrollViewIndicatorDelegate {
    func scrollTouch (_ point : CGPoint)
}

class ScrollViewIndicator: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var mDelegate : ScrollViewIndicatorDelegate?
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("scroll_Point \(point)")
        if let delegate = mDelegate {
            delegate.scrollTouch(point)
        }
        return super.hitTest(point, with: event)
    }
    
    public func setDelegate(_ delegate : ScrollViewIndicatorDelegate){
        mDelegate = delegate
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }
    
}
