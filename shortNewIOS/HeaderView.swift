//
//  HeaderView.swift
//  shortNewIOS
//
//  Created by SSd on 3/6/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let todayLabel = UILabel()
    let eventLabel = UILabel()
    var viewHeader = UIView()
    let cloudImage : CustomImageAvatar = {
        let imageView = CustomImageAvatar()
        imageView.image = #imageLiteral(resourceName: "cloud_morning")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var message : MessageHeader?{
        didSet{
            updateMessage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewHeader = UIView(frame: frame)
        viewHeader.backgroundColor = UIColor.clear
        addSubview(viewHeader)
        addConstrainView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addConstrainView(){
        // config header constraint
        cloudImage.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        viewHeader.addSubview(cloudImage)
        viewHeader.addSubview(todayLabel)
        //make size to fix
        todayLabel.textColor = UIColor.white
        let views = ["cloudImage" : cloudImage,"todayLabel" : todayLabel]
        let metrics = ["space" : 10,"spaceSmal" : 5 ,"cloudHeigh" : viewHeader.frame.height, "cloudWidh" : viewHeader.frame.height * 1.5]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[cloudImage(cloudHeigh)]|", options: [], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[cloudImage(cloudWidh)]-spaceSmal-[todayLabel]|", options: [.alignAllTop,.alignAllBottom], metrics: metrics, views: views))
    }
    
    func updateMessage(){
        todayLabel.text = message?.welcomeMessage
        todayLabel.textAlignment = .center
        //todayLabel.numberOfLines = 0
        todayLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        todayLabel.adjustsFontSizeToFitWidth = true
        if let avatar = message?.avatar {
            cloudImage.loadImageForUrl((avatar))
        }
        
    }
    
    
    
}
