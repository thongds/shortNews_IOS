//
//  UITextViewCustom.swift
//  shortNewIOS
//
//  Created by SSd on 12/15/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class UITextViewCustom: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public var text : String? {
        didSet{
            setNeedsLayout()
        }
    }
    public var textColor : UIColor? {
        didSet{
            setNeedsLayout()
        }
    }
    public var backgroundColorText : UIColor?{
        didSet{
            setNeedsLayout()
        }
    }
    public var fontSize : CGFloat?{
        didSet{
            setNeedsLayout()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
         addTextLayer()
    }
    func addTextLayer() {
        let textLayer = CATextLayer()
        
        if let text = text {
            textLayer.string = text
        }
        if let backgroundColorText = backgroundColorText {
            textLayer.backgroundColor = backgroundColorText.cgColor
        }
        if let textColor = textColor {
            textLayer.foregroundColor = textColor.cgColor
        }else{
            textLayer.foregroundColor = UIColor.black.cgColor
        }
        if let font = fontSize {
            textLayer.fontSize = font
        }else {
            textLayer.fontSize = 11
        }
        
        textLayer.frame = CGRect(x: 0, y: 0, width: 150, height: frame.height)
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.truncationMode = "end"
        textLayer.alignmentMode = kCAAlignmentLeft
        textLayer.isWrapped = true
        layer.addSublayer(textLayer)
    }
  
}
