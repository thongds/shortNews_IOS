//
//  ImageHelper.swift
//  shortNewIOS
//
//  Created by SSd on 4/3/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

extension UIImage{
    func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}
