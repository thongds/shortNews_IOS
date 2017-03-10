//
//  VideoTag.swift
//  shortNewIOS
//
//  Created by SSd on 12/26/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class VideoTag: UIView {

    
    let triangleShape = CAShapeLayer()
    var tagColor: UIColor? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        print("frame \(frame)")
        triangleShape.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        triangleShape.lineWidth = CGFloat(1)
        let path = UtilHelper.createTrianglePath(x1: CGPoint(x:0,y:0), x2: CGPoint(x : frame.width,y : 0), x3: CGPoint(x:frame.width,y:frame.height))
        triangleShape.path = path.cgPath
        if let tagColor = tagColor {
            triangleShape.fillColor = tagColor.cgColor
        }else{
            triangleShape.fillColor = UIColor.clear.cgColor
        }
        triangleShape.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(triangleShape)
    }

}
