//
//  UtilHelper.swift
//  shortNewIOS
//
//  Created by SSd on 12/15/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import Foundation
import UIKit
class UtilHelper {
    
    static func getMarginCell() -> CGFloat {
        return UIScreen.main.bounds.width/50
    }
    static func getScreenWidth() ->CGFloat{
        return UIScreen.main.bounds.width
    }
    static public func createCirclePath(arcCenter: CGPoint,
                                 radius: CGFloat,
                                 startAngle: CGFloat,
                                 endAngle: CGFloat,
                                 clockwise: Bool) -> UIBezierPath {
        
        return UIBezierPath(arcCenter: arcCenter,
                            radius: radius,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: clockwise)
    }
    static public func createTrianglePath(x1: CGPoint,x2 : CGPoint,x3: CGPoint) -> UIBezierPath{
        let closePath = UIBezierPath()
        closePath.move(to: x1)
        closePath.addLine(to: x2)
        closePath.addLine(to: x3)
        closePath.addLine(to: x1)
        return closePath
    }
    static public func generateContentTextMaxWidthForNewsPage() -> CGFloat{
        return  UtilHelper.getScreenWidth()-(UtilHelper.getMarginCell() * 2) - (Contraint.logoWidth.rawValue + 3*Contraint.normalSpace.rawValue)
    }
    static public func generateTitleTextMaxWidthForNewsPage(isHaveTagVideo : Bool) -> CGFloat{
        if isHaveTagVideo {
            return  UtilHelper.getScreenWidth()-(UtilHelper.getMarginCell() * 2) - (Contraint.logoWidth.rawValue + 3*Contraint.normalSpace.rawValue + Contraint.videoTagWidth.rawValue)
        }else{
            return  UtilHelper.getScreenWidth()-(UtilHelper.getMarginCell() * 2) - (Contraint.logoWidth.rawValue + 3*Contraint.normalSpace.rawValue)
        }
    }
}
