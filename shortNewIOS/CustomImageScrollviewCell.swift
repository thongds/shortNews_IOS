//
//  CustomImageScrollviewCell.swift
//  shortNewIOS
//
//  Created by SSd on 12/20/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class CustomImageScrollviewCell: CustomImage {

    var mScrollView : UIScrollView?
    
    init(frame: CGRect, scrollView : UIScrollView) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.point(inside: point, with: event){
            return mScrollView
        }
        return self
    }
    
}
