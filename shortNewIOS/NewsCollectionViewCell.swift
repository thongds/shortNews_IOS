//
//  NewsCollectionViewCell.swift
//  shortNewIOS
//
//  Created by SSd on 12/2/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import UIKit

import AVFoundation


class NewsCollectionViewCell: BaseCollectionViewCell {
    
    var newsDelegate : ClickNewsCellEvent?
    
    var newsResponse : NewsResponseModel? {
    
        didSet{
            if let is_ads = newsResponse?.is_ads, is_ads{
                configAdsLayout()
            }else{
                loadDataSource()
            }
        }
    }
    let imageViewThumb : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let contentText = UILabel()
    var titleText = UILabel()
    let leftShape = UIView()
    let videoTag = VideoTag()
    let play = PlayButtonView()
    let playButtomHeight :CGFloat = 60
    var isHadVideo : Bool = false
    let logoNews : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let contentImage : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let adsImage : CustomImage = {
        let imageView = CustomImage()
        imageView.image = #imageLiteral(resourceName: "default_image")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let videoTagImage = CustomImage()
    func loadDataSource(){
        print("loadDataSource")
        if let imageUrl = newsResponse?.post_image {
            imageViewThumb.loadImageForUrl(imageUrl)
        }
        if let logoUrl = newsResponse?.paper_logo{
            logoNews.loadImageForUrl(logoUrl)
        }
        if let contentImageUrl = newsResponse?.post_image{
            contentImage.loadImageForUrl(contentImageUrl)
        }
        titleText.textColor = UIColor(hexString: (newsResponse?.title_color)!)
        if let title = newsResponse?.post_title {
            titleText.text = title
        }
        if let content = newsResponse?.post_content{
            contentText.text = content
        }
        if let leftShapeColor = newsResponse?.paper_tag_color{
            leftShape.backgroundColor = UIColor(hexString: leftShapeColor)
        }
        if let videoTagColor = newsResponse?.paper_tag_color {
            videoTag.tagColor = UIColor(hexString: videoTagColor)
        }
        if let isVideo = newsResponse?.is_video {
            if isVideo == 1{
                if let videoTagImageLink = newsResponse?.video_tag_image{
                    isHadVideo = true
                    videoTagImage.loadImageForUrl(videoTagImageLink)
                }
            }else{
                isHadVideo = false
            }
        }
        
        setupNewsLayout()
    }

     func configMainViewsLayout() {
        print("setupViews")
        layer.cornerRadius = 9
        layer.masksToBounds = true
        titleText.numberOfLines = 0
        titleText.preferredMaxLayoutWidth = UtilHelper.generateTitleTextMaxWidthForNewsPage(isHaveTagVideo: false)
        
        contentText.numberOfLines = 0
        contentText.preferredMaxLayoutWidth = UtilHelper.generateContentTextMaxWidthForNewsPage()
        
        logoNews.translatesAutoresizingMaskIntoConstraints = false
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        contentText.translatesAutoresizingMaskIntoConstraints = false
        leftShape.translatesAutoresizingMaskIntoConstraints = false
        play.translatesAutoresizingMaskIntoConstraints = false
        videoTagImage.translatesAutoresizingMaskIntoConstraints = false
        titleText.backgroundColor = UIColor.clear
        
        addSubview(logoNews)
        addSubview(contentImage)
        addSubview(titleText)
        addSubview(contentText)
        addSubview(leftShape)
        
        titleText.isUserInteractionEnabled = true
        let tabRec = MyTapGestureRecognizer(target: self, action: #selector(self.clickTitle))
        tabRec.id = newsResponse?.id
        titleText.addGestureRecognizer(tabRec)
        
        let views = [ "logoNews" : logoNews,"contentImage" : contentImage,"contentText": contentText,"titleText": titleText,"leftShape" : leftShape,"videoTag" : videoTagImage]
        let firstMatric = ["normalSpace" : Contraint.normalSpace.rawValue,"logoWidth" : Contraint.logoWidth.rawValue,"logoHeigh" : Contraint.logoHeight.rawValue,"contentImageHeight" :Contraint.contentImageHeight.rawValue,"videoTagWidth" : Contraint.videoTagWidth.rawValue]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[leftShape]|", options: [], metrics: firstMatric, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftShape(==8)]", options: [], metrics: firstMatric, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-normalSpace-[logoNews(==logoHeigh)]", options: [], metrics: firstMatric, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftShape]-2-[logoNews(==logoWidth)]", options: [], metrics: firstMatric, views: views))
       NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[logoNews]-normalSpace-[contentImage(==contentImageHeight)]", options: [.alignAllLeading,.alignAllTrailing], metrics: firstMatric, views: views))
        //title and contentText Constraint
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[logoNews]-normalSpace-[titleText]", options: [.alignAllTop], metrics: firstMatric, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleText]-normalSpace-[contentText]", options: [.alignAllLeading], metrics: firstMatric, views: views))
    }
    
    func clickTitle(tabRec : MyTapGestureRecognizer){
        if let newsDelegate = newsDelegate, let id = tabRec.id{
            newsDelegate.clickTitle(id: id)
        }
    }
    func setupNewsLayout() {
        configMainViewsLayout()
        configTagVideoLayout()
        //right site
    }
    
    func configTagVideoLayout(){
        let yBtm = Contraint.contentImageHeight.rawValue/2 - playButtomHeight/2
        let xBtm = Contraint.logoWidth.rawValue/2 - playButtomHeight/2
        let views = ["videoTag" : videoTagImage,"play" : play,"contentImage" : contentImage]
        let firstMatric = ["videoTagWidth" : Contraint.videoTagWidth.rawValue,"yBtm" : yBtm,"xBtm" :xBtm, "btmHeight":playButtomHeight]
        if isHadVideo {
            addSubview(videoTagImage)
            contentImage.addSubview(play)
            
            titleText.preferredMaxLayoutWidth = UtilHelper.generateTitleTextMaxWidthForNewsPage(isHaveTagVideo: true)
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[videoTag(videoTagWidth)]", options: [], metrics: firstMatric, views: views))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[videoTag(videoTagWidth)]|", options: [], metrics: firstMatric, views: views))
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-yBtm-[play(btmHeight)]", options: [.alignAllCenterY], metrics: firstMatric, views: views))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-xBtm-[play(btmHeight)]", options: [.alignAllCenterX], metrics: firstMatric, views: views))
        }

    }
    
    func configAdsLayout(){
        adsImage.translatesAutoresizingMaskIntoConstraints = false
        adsImage.image = #imageLiteral(resourceName: "default_image")
        addSubview(adsImage)
        let views = ["adsImage" : adsImage]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[adsImage]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[adsImage]|", options: [], metrics: nil, views: views))
        if let post_image = newsResponse?.post_image {
            adsImage.loadImageForUrl(post_image)
        }
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    override func prepareForReuse() {
        videoTagImage.image = nil
        adsImage.image = nil
        isHadVideo = false
        play.removeFromSuperview()
        titleText.preferredMaxLayoutWidth = UtilHelper.generateTitleTextMaxWidthForNewsPage(isHaveTagVideo: false)
        super.prepareForReuse()
    }
    
    func setNewsDelegate(delegate : ClickNewsCellEvent){
        self.newsDelegate = delegate
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
       super.apply(layoutAttributes)
//        print("setupWithAutoLayout a2")
//        let attributes = layoutAttributes as! NewsCollectionViewAttributes
//        let views = [ "view": view,"logoNews" : logoNews,"contentImage" : contentImage,"contentText": contentText,"titleText": titleText,"leftShape" : leftShape,"videoTag" : videoTag]
//        let firstMatric = ["viewHeight":attributes.contentHeight + 400,"normalSpace" : Contraint.normalSpace.rawValue,"logoWidth" : Contraint.logoWidth.rawValue,"logoHeigh" : Contraint.logoHeight.rawValue,"contentImageHeight" :Contraint.contentImageHeight.rawValue]
//         print("heightMax 2 \(attributes.contentHeight)")
       
    
    }
    class MyTapGestureRecognizer: UITapGestureRecognizer {
        var id: Int?
        
    }
    
}
