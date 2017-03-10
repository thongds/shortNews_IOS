//
//  SocialCollectionViewCell.swift
//  shortNewIOS
//
//  Created by SSd on 12/2/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit


class SocialCollectionViewCell: BaseCollectionViewCell {
    
    var socialResponse : SocialResponse? {
        
        didSet{
            loadDataSource()
        }
    }
    var isHavePostImage = false
    var leftWidth : CGFloat = 0
    let fanPageName = UILabel()
    var titleText = UILabel()
    let leftShape = UIView()
    let moreImageView = UIView()
    let numberImageLeft = UILabel()
    var numberImageLeftContant = 0
    let socialLogoImage : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let fanpageLogo : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(Contraint.logoWidth.rawValue/2)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let contentImage : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleAspectFit
        //imageView.clipsToBounds = true
        return imageView
    }()
    
    func loadDataSource(){
        if let socialLogoimageUrl = socialResponse?.social_logo {
            socialLogoImage.loadImageForUrl(socialLogoimageUrl)
        }
        if let fanPageLogoUrl = socialResponse?.fanpage_logo{
            fanpageLogo.loadImageForUrl(fanPageLogoUrl)
        }
        if let contentImageUrl = socialResponse?.post_image_url{
            isHavePostImage = true
            if let sperateTag = socialResponse?.separate_image_tag{
                let linkImage = contentImageUrl.components(separatedBy: sperateTag )
                if linkImage.count > 0 {
                    if let social_content_type_id = socialResponse?.social_content_type_id {
                        let linkImageIndex = social_content_type_id == 1 ? linkImage[0] : linkImage[1]
                        contentImage.loadImageForUrl(linkImageIndex)
                        if social_content_type_id == 1{
                            numberImageLeftContant =  linkImage.count - 2
                        }
                    }
                    
                }
            }
        }else{
            isHavePostImage = true
        }
        if let title = socialResponse?.title {
            titleText.text = title
            
        }
        if let fanPageNameText = socialResponse?.fanpage_name{
            fanPageName.text = fanPageNameText
        }
        if let leftShapeColor = socialResponse?.color_tag{
            leftShape.backgroundColor = UIColor(hexString: leftShapeColor)
        }
        setupWithContraint()
        //setupViews()
    }
    override func setupViews() {
         leftWidth =  UtilHelper.getScreenWidth()-(UtilHelper.getMarginCell()*2) - (Contraint.logoWidth.rawValue + 3*Contraint.normalSpace.rawValue)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        socialLogoImage.translatesAutoresizingMaskIntoConstraints = false
        fanpageLogo.translatesAutoresizingMaskIntoConstraints = false                                                                                                                                                                                                                                                                                                                                                                                                                                              
        fanPageName.translatesAutoresizingMaskIntoConstraints = false
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        leftShape.translatesAutoresizingMaskIntoConstraints = false
        moreImageView.translatesAutoresizingMaskIntoConstraints = false
        numberImageLeft.translatesAutoresizingMaskIntoConstraints = false
        numberImageLeft.font = UIFont.systemFont(ofSize: 28)
        numberImageLeft.textColor = UIColor.white
        addSubview(socialLogoImage)
        addSubview(fanpageLogo)
        addSubview(fanPageName)
        addSubview(titleText)
        addSubview(leftShape)
        
        
        let views = ["leftShape" : leftShape ,"titleText": titleText, "socialLogoImage" : socialLogoImage,"fanpageLogo" : fanpageLogo,"fanPageName": fanPageName, "contentImage" : contentImage]
       
        let metrics = ["logoWidth":Contraint.logoWidth.rawValue,"logoHeight" : Contraint.logoHeight.rawValue, "normalSpace" : Contraint.normalSpace.rawValue,"leftWidth" : leftWidth,"contentImageHeight" : Contraint.contentImageHeight.rawValue]
        //left site
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[leftShape]|", options: [], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftShape(==8)]", options: [], metrics: metrics, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-normalSpace-[socialLogoImage(==logoHeight)]", options: [], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftShape]-2-[socialLogoImage(==logoWidth)]", options: [], metrics: metrics, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[socialLogoImage]-normalSpace-[fanpageLogo(==logoWidth)]", options: [.alignAllLeading,.alignAllTrailing], metrics: metrics, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[fanpageLogo]-[fanPageName]", options: [.alignAllLeading,.alignAllTrailing], metrics: metrics, views: views))
        //right site
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[socialLogoImage]-normalSpace-[titleText]-normalSpace-|", options: [.alignAllTop], metrics: metrics, views: views))
        
       
    }
    
    func setupWithContraint(){
        if isHavePostImage{
            let views = [ "titleText": titleText, "socialLogoImage" : socialLogoImage,"fanpageLogo" : fanpageLogo,"fanPageName": fanPageName, "contentImage" : contentImage]
            let metrics = ["logoWidth":Contraint.logoWidth.rawValue,"logoHeight" : Contraint.logoHeight.rawValue, "normalSpace" : Contraint.normalSpace.rawValue,"leftWidth" : leftWidth,"contentImageHeight" : Contraint.contentImageHeight.rawValue]
            addSubview(contentImage)
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[contentImage(==leftWidth)]", options: [], metrics: metrics, views: views))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleText]-[contentImage(==contentImageHeight)]", options: [.alignAllLeading], metrics: metrics, views: views))
            // contraint for imagelabel
            if numberImageLeftContant > 0 {
                moreImageView.backgroundColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 79/255)
                contentImage.addSubview(moreImageView)
                let moreImageWidth : CGFloat = 100
                NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[moreImageView(moreImageWidth)]|", options: [], metrics: ["moreImageWidth" : moreImageWidth], views: ["moreImageView":moreImageView]))
                NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[moreImageView(moreImageWidth)]|", options: [], metrics: ["moreImageWidth" : moreImageWidth], views: ["moreImageView":moreImageView]))
            
                moreImageView.addSubview(numberImageLeft)
                let numberLabelWidth : CGFloat = 50
                let numberLabelHeight : CGFloat = 50
                let xNumberPos = moreImageWidth/2 - numberLabelWidth/2
                let yNumberPos = moreImageWidth/2 - numberLabelHeight/2
                let labelMetric = ["xNumberPos" : xNumberPos , "yNumberPos" : yNumberPos,"numberLabelWidth" : numberLabelWidth,"numberLabelHeight" : numberLabelHeight]
                NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-yNumberPos-[numberImageLeft(numberLabelHeight)]", options: [], metrics: labelMetric, views: ["numberImageLeft" : numberImageLeft]))
                NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-xNumberPos-[numberImageLeft(numberLabelWidth)]", options: [], metrics: labelMetric, views: ["numberImageLeft" : numberImageLeft]))
                numberImageLeft.text = "+\(numberImageLeftContant)"
            }
            
        }

    }

    func setupViewsWithOutContraint() {
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        socialLogoImage.translatesAutoresizingMaskIntoConstraints = false
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        titleText.backgroundColor = UIColor.clear
        leftShape.frame = CGRect(x: 0, y: 0, width: Contraint.normalSpace.rawValue/2, height: frame.height)
        let space = Contraint.normalSpace.rawValue
        let leftCellContentHeight = Contraint.normalSpace.rawValue + Contraint.logoHeight.rawValue + Contraint.normalSpace.rawValue + Contraint.contentImageHeight.rawValue
        var yLogoPosition : CGFloat = 0
        if leftCellContentHeight <= frame.height {
            yLogoPosition = frame.height/2 - (Contraint.normalSpace.rawValue + Contraint.logoHeight.rawValue + Contraint.normalSpace.rawValue + Contraint.contentImageHeight.rawValue)/2
        }else{
            yLogoPosition = space
        }
        socialLogoImage.frame = CGRect(x: space, y: yLogoPosition, width: Contraint.logoWidth.rawValue, height: Contraint.logoHeight.rawValue)
        fanpageLogo.frame = CGRect(x: space, y: socialLogoImage.frame.origin.y + socialLogoImage.frame.height + space, width: Contraint.logoWidth.rawValue, height: Contraint.logoWidth.rawValue)
        fanPageName.numberOfLines = 0
        fanPageName.sizeToFit()
        fanPageName.frame = CGRect(x: fanpageLogo.frame.origin.x, y: fanpageLogo.frame.origin.y + fanpageLogo.frame.height , width: Contraint.logoWidth.rawValue, height: fanPageName.frame.height)
        
        // right position
        let leftWidth = frame.width - (Contraint.logoWidth.rawValue + 2*space)
        titleText.numberOfLines = 0
        titleText.sizeToFit()
        titleText.frame = CGRect(x: Contraint.logoWidth.rawValue + 2*space, y: space, width: leftWidth , height: titleText.frame.height)
        
        contentImage.frame = CGRect(x: titleText.frame.origin.x, y: titleText.frame.origin.y + titleText.frame.height, width: leftWidth, height: Contraint.contentImageHeight.rawValue)
        
        
        addSubview(leftShape)
        addSubview(socialLogoImage)
        addSubview(fanpageLogo)
        addSubview(fanPageName)
        addSubview(titleText)
        addSubview(contentImage)
        
        
    }
    override func prepareForReuse() {
        numberImageLeft.text = ""
        numberImageLeftContant = 0
        moreImageView.removeFromSuperview()
        super.prepareForReuse()
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    
    }
    

}








