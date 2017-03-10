//
//  LeftLineShape.swift
//  shortNewIOS
//
//  Created by SSd on 12/16/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

class LeftLineShape: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var backgroundColor: UIColor?{
        didSet{
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawShape()
    }
    
    func drawShape(){
        

        
    }
}
